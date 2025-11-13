<script setup>
  import { computed, nextTick, onMounted, reactive, ref } from 'vue'
  import { VueDraggable } from 'vue-draggable-plus'
  import { useRoute, useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import ImageManager from '@/components/ImageManager.vue'
  import PageTitle from '@/components/PageTitle.vue'
  import RichTextEditor from '@/components/RichTextEditor.vue'
  import { Event } from '@/models'
  import { getEventImageUrl, isObjEmpty, toLocalISOString } from '@/others/util.js'

  definePage({
    name: 'eventEdit',
    meta: {
      requiresAuth: true,
      layout: 'default',
      title: 'Edit Event',
    },
  })

  const { mobile } = useDisplay()
  const route = useRoute()
  const router = useRouter()
  const store = useStore()

  // Event model for editing
  const eventInit = new Event()
  const editingEvent = reactive({ ...eventInit })
  const newUploads = ref()
  const rmImages = ref()

  const form = ref(null)
  const isFormValid = ref(true)
  const isTemporary = ref(false)
  const autoDeleteDays = ref(null)
  const isCustomDays = ref(false)
  const customDays = ref(null)

  const dayOptions = [1, 7, 14, 30, 60, 90, { title: 'Custom', value: 'custom' }]

  const calculatedExpirationDate = computed(() => {
    if (!isTemporary.value) return null
    const days = isCustomDays.value ? customDays.value : autoDeleteDays.value
    if (!days) return null
    // Calculate from current date (not original created_at) when editing
    const currentDate = new Date()
    const date = new Date(currentDate)
    date.setDate(date.getDate() + Number.parseInt(days))
    return date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
  })

  const currentExpirationDate = computed(() => {
    if (editingEvent.expiresAt) {
      return new Date(editingEvent.expiresAt).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
      })
    }
    return null
  })

  function handleDaysChange (value) {
    if (value === 'custom') {
      isCustomDays.value = true
      autoDeleteDays.value = null
    } else {
      isCustomDays.value = false
      autoDeleteDays.value = value
      customDays.value = null
    }
  }

  const allEventCategories = computed(() =>
    store.state.category.categories.map(item => item.name),
  )

  const storeModule = computed(() => {
    if (route.query.src === 'browse') return 'eventBrowse'
    if (route.query.src === 'wall') return 'eventWall'
    if (route.query.src === 'single') return 'eventSingle'
    // Fallback to wall module if source is missing on reload
    return 'eventWall'
  })

  const currentUser = computed(() => store.getters['auth/getCurrentUser'])
  const storedEditingEvent = computed(
    () => store.state[`${storeModule.value}`].editingEvent,
  )

  function removeExistingImage (index) {
    rmImages.value.push(editingEvent.images[index])
    editingEvent.images.splice(index, 1)
  }

  function handleUploadChange (files) {
    // If files is empty (clear all), reset the images
    if (!files || files.length === 0) {
      newUploads.value = []
      return
    }

    // Check if this is a file removal by comparing file objects
    const isRemoval = files.length < newUploads.value.length
      && files.every(newFile =>
        newUploads.value.some(oldFile =>
          oldFile.name === newFile.name
          && oldFile.size === newFile.size
          && oldFile.lastModified === newFile.lastModified,
        ),
      )

    if (isRemoval) {
      newUploads.value = files
      return
    }

    // If we're here, it's an addition - append new files
    newUploads.value.push(...files)
  }

  // Helper to strip HTML tags and get text length for validation
  function getTextLength (html) {
    if (!html) return 0
    const temp = document.createElement('div')
    temp.innerHTML = html
    return (temp.textContent || temp.innerText || '').length
  }

  async function handleSubmitEditEvent () {
    const { valid } = await form.value.validate()
    if (!valid) {
      await store.commit('addSnackbar', {
        text: 'Please fill in all required fields correctly',
        color: 'error',
      })
      return
    }

    // Validate description
    const descLength = getTextLength(editingEvent.description)
    if (!editingEvent.description || descLength === 0) {
      isFormValid.value = false
      await store.commit('addSnackbar', { text: 'Description is required!', color: 'error' })
      return
    }
    if (descLength > 1000) {
      isFormValid.value = false
      await store.commit('addSnackbar', { text: 'Description must not exceed 1000 characters!', color: 'error' })
      return
    }

    // Validate total image count
    const totalCount = editingEvent.images.length + newUploads.value.length

    if (totalCount > 25) {
      isFormValid.value = false
      await store.commit('addSnackbar',
                         { text: `Total images cannot exceed 25! Total Count ${totalCount}`, color: 'error' })
      return
    }

    const formData = new FormData()
    formData.append('id', editingEvent.id)
    formData.append('title', editingEvent.title)
    formData.append('date', toLocalISOString(editingEvent.date).slice(0, 10))
    formData.append('startTime', editingEvent.startTime)
    formData.append('endTime', editingEvent.endTime)
    formData.append('location', editingEvent.location)
    formData.append('description', editingEvent.description)
    formData.append('category', editingEvent.category)
    formData.append('images', JSON.stringify(editingEvent.images))
    formData.append('rmImages', JSON.stringify(rmImages.value))
    if (isTemporary.value) {
      const days = isCustomDays.value ? customDays.value : autoDeleteDays.value
      if (days && Number.parseInt(days) > 0) {
        formData.append('autoDeleteDays', days)
      } else {
        formData.append('autoDeleteDays', '')
      }
    } else {
      // If temporary is disabled, send empty string to remove expiration
      formData.append('autoDeleteDays', '')
    }
    // Send createdAt for accurate calculation
    if (editingEvent.createdAt) {
      formData.append('createdAt', editingEvent.createdAt)
    }

    for (const item of newUploads.value) {
      formData.append('files', item)
    }

    store
      .dispatch(`${storeModule.value}/editEvent`, formData)
      .then(() => {
        store.commit('setActionSource', 'edit')
        switch (route.query.src) {
          case 'browse': {
            router.push({ name: 'browse' })

            break
          }
          case 'single': {
            router.push({ name: 'wall', params: { id: currentUser.value.slug || currentUser.value.id } })

            break
          }
          case 'wall': {
            router.push({ name: 'wall', params: { id: currentUser.value.slug || currentUser.value.id } })

            break
          }
          default: {
            // Fallback to wall if src is missing
            router.push({ name: 'wall', params: { id: currentUser.value.slug || currentUser.value.id } })
          }
        }
      })
      .catch(error => {
        console.error('Error editing event:', error)
        store.commit('addSnackbar', {
          text: error?.response?.data?.message || 'Failed to update event',
          color: 'error',
        })
      })
  }

  onMounted(async () => {
    if (isObjEmpty(storedEditingEvent.value)) {
      await store.dispatch(
        `${storeModule.value}/setEditingEvent`,
        route.params.id,
      )
    }

    Object.assign(editingEvent, {
      ...storedEditingEvent.value,
      date: new Date(storedEditingEvent.value.date),
    })

    // Ensure RichTextEditor is ready before setting description
    await nextTick()

    // Set temporary post state if expiresAt exists
    if (editingEvent.expiresAt) {
      isTemporary.value = true
      // Calculate days remaining from NOW until expiration (not from created_at)
      // This way when user selects a new value, it calculates from current date
      const now = new Date()
      const expires = new Date(editingEvent.expiresAt)
      // Normalize both to UTC midnight for accurate day calculation
      const nowUTC = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), 0, 0, 0, 0))
      const expiresUTC = new Date(Date.UTC(expires.getUTCFullYear(), expires.getUTCMonth(), expires.getUTCDate(), 0, 0, 0, 0))
      const diffTime = expiresUTC - nowUTC
      const diffDays = Math.round(diffTime / (1000 * 60 * 60 * 24))
      const standardDays = [1, 7, 14, 30, 60, 90]
      if (diffDays > 0 && standardDays.includes(diffDays)) {
        autoDeleteDays.value = diffDays
        isCustomDays.value = false
        customDays.value = null
      } else if (diffDays > 0) {
        // If not in standard options, use custom value
        isCustomDays.value = true
        customDays.value = diffDays
        autoDeleteDays.value = 'custom'
      } else {
        // If expired or 0 days, default to 7 days
        autoDeleteDays.value = 7
        isCustomDays.value = false
        customDays.value = null
      }
    }

    newUploads.value = []
    rmImages.value = []
  })
</script>

<template>
  <v-container>
    <page-title subtitle="Update event details" title="Edit Event">
      <v-btn icon="mdi-arrow-left" variant="text" @click="$router.back()" />
    </page-title>

    <div class="page-content">
      <v-row align="center" justify="center">
        <v-col cols="12" md="8" sm="10">
          <v-form
            ref="form"
            v-model="isFormValid"
            fast-fail
            @submit.prevent="handleSubmitEditEvent"
          >
            <v-text-field
              v-model="editingEvent.title"
              class="mt-2"
              clearable
              hide-details="auto"
              label="Title"
              required
              :rules="[
                (v) => !!v || 'Title is required!',
                (v) => (v && v.length <= 50) || 'Must not exceed 50 characters',
              ]"
              variant="solo"
            />

            <v-text-field
              v-model="editingEvent.location"
              class="mt-2"
              clearable
              hide-details="auto"
              label="Location"
              :rules="[
                (v) => !v || (v && v.length <= 50) || 'Must not exceed 50 characters',
              ]"
              variant="solo"
            />

            <div class="mt-2">
              <label class="text-body-2 text-medium-emphasis mb-2 d-block">Description</label>
              <rich-text-editor
                :key="`editor-${editingEvent.id}-${editingEvent.description ? 'loaded' : 'empty'}`"
                v-model="editingEvent.description"
                placeholder="Describe your event..."
              />
              <div class="text-caption text-medium-emphasis mt-1">
                {{ getTextLength(editingEvent.description) }} / 1000 characters
              </div>
            </div>

            <!-- Temporary Post Option -->
            <v-card class="mt-4">
              <v-card-text>
                <div class="d-flex align-center mb-2">
                  <v-switch
                    v-model="isTemporary"
                    color="primary"
                    hide-details="auto"
                    label="Make this post temporary"
                  />
                </div>
                <div v-if="currentExpirationDate && !isTemporary" class="text-caption text-medium-emphasis mb-2">
                  Current expiration: <strong>{{ currentExpirationDate }}</strong>
                </div>
                <div v-if="isTemporary" class="mt-3">
                  <v-select
                    v-model="autoDeleteDays"
                    hide-details="auto"
                    :items="dayOptions.map(d => typeof d === 'object' ? d : { title: `${d} ${d === 1 ? 'day' : 'days'}`, value: d })"
                    label="Auto-delete after"
                    variant="solo"
                    @update:model-value="handleDaysChange"
                  />
                  <v-number-input
                    v-if="isCustomDays"
                    v-model="customDays"
                    class="mt-3"
                    hide-details="auto"
                    label="Enter number of days"
                    max="365"
                    min="1"
                    :rules="[
                      (v) => !!v || 'Number of days is required',
                      (v) => (v && parseInt(v) >= 1) || 'Must be at least 1 day',
                      (v) => (v && parseInt(v) <= 365) || 'Maximum 365 days'
                    ]"
                    variant="solo"
                  />
                  <div v-if="calculatedExpirationDate" class="text-caption text-medium-emphasis mt-2">
                    This post will expire on: <strong>{{ calculatedExpirationDate }}</strong>
                  </div>
                </div>
              </v-card-text>
            </v-card>

            <v-row :no-gutters="!!mobile">
              <v-col class="mt-2" cols="12" md="6">
                <v-select
                  v-model="editingEvent.category"
                  clearable
                  hide-details
                  :items="allEventCategories"
                  label="Category"
                  required
                  :rules="[(v) => !!v || 'Category is required!']"
                  variant="solo"
                />
              </v-col>
              <v-col class="mt-2" cols="12" md="6">
                <v-date-input
                  v-model="editingEvent.date"
                  color="primary"
                  hide-details="auto"
                  label="Date"
                  prepend-icon=""
                  prepend-inner-icon="mdi-calendar"
                  :rules="[(v) => !!v || 'Date is required!']"
                  variant="solo"
                />
              </v-col>
            </v-row>

            <v-row :no-gutters="!!mobile">
              <v-col class="mt-2 mt-md-n3" cols="12" md="6">
                <time-picker
                  v-model="editingEvent.startTime"
                  label="Start Time"
                  :rules="[(v) => !!v || 'Start Time is required!']"
                  :show-icon="true"
                  variant="solo"
                />
              </v-col>
              <v-col class="mt-2 mt-md-n3" cols="12" md="6">
                <time-picker
                  v-model="editingEvent.endTime"
                  label="End Time"
                  :show-icon="true"
                  variant="solo"
                />
              </v-col>
            </v-row>

            <VueDraggable
              v-model="editingEvent.images"
              animation="150"
              class="images-grid container-border"
              filter=".no-drag"
              :force-fallback="true"
              ghost-class="ghost"
            >
              <div
                v-for="(img, index) in editingEvent.images"
                :key="img"
                class="image-item"
              >
                <image-manager
                  v-if="img"
                  :hide-delete="false"
                  max-height="200px"
                  max-width="100%"
                  :src="getEventImageUrl(img)"
                  @delete="removeExistingImage(index)"
                />
              </div>
            </VueDraggable>

            <div class="container-border">
              <v-alert
                color="primary"
                density="comfortable"
                variant="tonal"
              >Add up to 25 new images. First selected becomes the cover if you remove the existing cover.
              </v-alert>

              <v-file-upload
                accept="image/*"
                class="mt-2"
                clearable
                density="compact"
                :hide-browse="false"
                :model-value="newUploads"
                multiple
                show-size
                title="Upload New Images (up to 25)"
                variant=""
                @update:model-value="handleUploadChange"
              />
            </div>

            <v-row justify="end">
              <v-col cols="auto">
                <v-btn
                  class="mt-5"
                  color="primary"
                  :density="mobile ? 'comfortable' : 'default'"
                  type="submit"
                  variant="flat"
                >Confirm
                </v-btn>
              </v-col>
            </v-row>
          </v-form>
        </v-col>
      </v-row>
    </div>
  </v-container>
</template>

<style scoped>
.images-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 12px;
}

.image-item {
  cursor: move;
}

.ghost {
  opacity: 0.6;
}

@media (max-width: 960px) {
  .images-grid {
    grid-template-columns: 1fr;
  }
}
</style>
