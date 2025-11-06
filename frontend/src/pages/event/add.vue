<script setup>
  import { computed, onMounted, reactive, ref } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import PageTitle from '@/components/PageTitle.vue'
  import RichTextEditor from '@/components/RichTextEditor.vue'
  import TimePicker from '@/components/TimePicker.vue'
  import PostLimitStatus from '@/components/PostLimitStatus.vue'
  import { Event } from '@/models'
  import { toLocalISOString } from '@/others/util.js'

  definePage({
    name: 'eventAdd',
    meta: {
      requiresAuth: true,
      layout: 'default',
      title: 'Add Event',
    },
  })

  const { mobile } = useDisplay()
  const route = useRoute()
  const router = useRouter()
  const store = useStore()

  const currentUser = store.getters['auth/getCurrentUser']
  const isSubscriptionValid = computed(
    () => store.getters['subscription/isSubscriptionValid'],
  )
  const allEventCategories = computed(() =>
    store.state.category.categories.map(item => item.name),
  )

  // Event model for adding new event
  const eventInit = new Event({
    date: new Date(),
    startTime: '00:00',
    endTime: '23:59',
  })
  const newEvent = reactive({ ...eventInit })
  const form = ref(null)
  const isFormValid = ref(true)
  const isTemporary = ref(false)
  const autoDeleteDays = ref(null)
  const isCustomDays = ref(false)
  const customDays = ref(null)
  const postLimitStatusRef = ref(null)

  const dayOptions = [1, 7, 14, 30, 60, 90, { title: 'Custom', value: 'custom' }]

  const calculatedExpirationDate = computed(() => {
    if (!isTemporary.value) return null
    const days = isCustomDays.value ? customDays.value : autoDeleteDays.value
    if (!days) return null
    const date = new Date()
    date.setDate(date.getDate() + Number.parseInt(days))
    return date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
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

  function handleUploadChange (files) {
    // If files is empty (clear all), reset the images
    if (!files || files.length === 0) {
      newEvent.images = []
      return
    }

    // Check if this is a file removal by comparing file objects
    // If all files in the new selection exist in the old selection, it's likely a removal
    const isRemoval = files.length < newEvent.images.length
      && files.every(newFile =>
        newEvent.images.some(oldFile =>
          oldFile.name === newFile.name
          && oldFile.size === newFile.size
          && oldFile.lastModified === newFile.lastModified,
        ),
      )

    if (isRemoval) {
      newEvent.images = files
      return
    }

    // If we're here, it's an addition - append new files
    newEvent.images.push(...files)
  }

  // Helper to strip HTML tags and get text length for validation
  function getTextLength (html) {
    if (!html) return 0
    const temp = document.createElement('div')
    temp.innerHTML = html
    return (temp.textContent || temp.innerText || '').length
  }

  async function addEvent () {
    // Check post limit before submission using store
    const limitStatus = store.getters['subscription/postLimitStatus']
    if (!limitStatus.isPremium && limitStatus.remaining === 0) {
      store.commit('addSnackbar', {
        text: 'Post limit reached. Upgrade to premium for unlimited posts!',
        color: 'error',
      })
      return router.push({ name: 'pricing' })
    }

    await form.value.validate()
    if (!isFormValid.value) return

    // Validate description
    const descLength = getTextLength(newEvent.description)
    if (!newEvent.description || descLength === 0) {
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
    const imageCount = newEvent.images ? (Array.isArray(newEvent.images) ? newEvent.images.length : 1) : 0

    if (imageCount > 25) {
      isFormValid.value = false
      await store.commit('addSnackbar',
                         { text: `Total images cannot exceed 25! Total Count ${imageCount}`, color: 'error' })
      return
    }

    const formData = new FormData()
    formData.append('title', newEvent.title)
    formData.append('date', toLocalISOString(newEvent.date).slice(0, 10))
    formData.append('startTime', newEvent.startTime)
    formData.append('endTime', newEvent.endTime)
    formData.append('location', newEvent.location)
    formData.append('description', newEvent.description)
    formData.append('category', newEvent.selectedCategory)
    if (isTemporary.value) {
      const days = isCustomDays.value ? customDays.value : autoDeleteDays.value
      if (days && Number.parseInt(days) > 0) {
        formData.append('autoDeleteDays', days)
      }
    }
    for (const file of newEvent.images) {
      formData.append('files', file)
    }
    formData.append('isFeatured', false)

    store.dispatch('eventWall/addEvent', formData).then(() => {
      // Reset form after successful addition
      Object.assign(newEvent, {
        ...eventInit,
        selectedCategory: null,
        images: [],
      })
      isTemporary.value = false
      autoDeleteDays.value = null
      isCustomDays.value = false
      customDays.value = null
      // Reload limit status after successful post
      store.dispatch('subscription/fetchPostLimitStatus', currentUser.id).then(() => {
        // Also reload component if it exists
        if (postLimitStatusRef.value) {
          postLimitStatusRef.value.loadLimitStatus()
        }
      })
      router.push({ name: 'wall', params: { id: currentUser.slug || currentUser.id } })
    }).catch((error) => {
      // Handle post limit error
      if (error.response?.status === 403) {
        store.commit('addSnackbar', {
          text: error.response?.data?.msg || 'Post limit reached. Upgrade to premium for unlimited posts!',
          color: 'error',
        })
        // Reload limit status from store
        store.dispatch('subscription/fetchPostLimitStatus', currentUser.id).then(() => {
          if (postLimitStatusRef.value) {
            postLimitStatusRef.value.loadLimitStatus()
          }
        })
      }
    })
  }

  onMounted(async () => {
    await store.dispatch('subscription/fetchPremiumSubscriptionData', {
      userId: currentUser.id,
    })
    // Load post limit status if not already loaded
    if (!store.getters['subscription/postLimitStatus']?.isPremium && 
        store.getters['subscription/postLimitStatus']?.remaining === undefined) {
      await store.dispatch('subscription/fetchPostLimitStatus', currentUser.id)
    }
    // Allow free users to access the page - they'll see the limit status
    Object.assign(newEvent, { ...eventInit, selectedCategory: null, images: [] })
    await store.dispatch('category/setCategories')
  })
</script>

<template>
  <v-container>
    <page-title subtitle="Create a new event" title="Add Event">
      <v-btn icon="mdi-arrow-left" variant="text" @click="$router.back()" />
    </page-title>
    <div class="page-content">
      <v-row align="center" justify="center">
      <v-col cols="12" md="8" sm="10">
        <!-- Post Limit Status -->
        <post-limit-status
          ref="postLimitStatusRef"
          class="mb-4"
        />
        <div>
          <v-form
            ref="form"
            v-model="isFormValid"
            fast-fail
            @submit.prevent="addEvent"
          >
            <v-text-field
              v-model="newEvent.title"
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
              v-model="newEvent.location"
              class="mt-2"
              clearable
              hide-details="auto"
              label="Location"
              required
              :rules="[
                (v) => !!v || 'Location is required!',
                (v) => (v && v.length <= 50) || 'Must not exceed 50 characters',
              ]"
              variant="solo"
            />

            <div class="mt-2">
              <label class="text-body-2 text-medium-emphasis mb-2 d-block">Description</label>
              <rich-text-editor
                v-model="newEvent.description"
                placeholder="Describe your event..."
              />
              <div class="text-caption text-medium-emphasis mt-1">
                {{ getTextLength(newEvent.description) }} / 1000 characters
              </div>
            </div>
            <v-row :no-gutters="!!mobile">
              <v-col class="mt-2" cols="12" md="6">
                <v-select
                  v-model="newEvent.selectedCategory"
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
                  v-model="newEvent.date"
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
            <v-row class="mt-md-n1" :no-gutters="!!mobile">
              <v-col class="mt-2 mt-md-0" cols="12" md="6">
                <time-picker
                  v-model="newEvent.startTime"
                  label="Start Time"
                  :rules="[(v) => !!v || 'Start Time is required!']"
                  :show-icon="true"
                  variant="solo"
                />
              </v-col>
              <v-col class="mt-2 mt-md-0" cols="12" md="6">
                <time-picker
                  v-model="newEvent.endTime"
                  hide-details="auto"
                  label="End Time"
                  required
                  :rules="[(v) => !!v || 'End Time is required!']"
                  :show-icon="true"
                  variant="solo"
                />
              </v-col>
            </v-row>

            <!-- Temporary Post Option -->
            <v-card class="mt-4" variant="outlined">
              <v-card-text>
                <div class="d-flex align-center mb-2">
                  <v-switch
                    v-model="isTemporary"
                    color="primary"
                    hide-details
                    label="Make this post temporary"
                  />
                </div>
                <div v-if="isTemporary" class="mt-3">
                  <v-select
                    v-model="autoDeleteDays"
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

            <div class="container-border">
              <v-alert
                density="comfortable"
                type="info"
                variant="tonal"
              >First selected image will be used as the cover.
              </v-alert>

              <v-file-upload
                accept="image/*"
                class="mt-2"
                clearable
                density="compact"
                :hide-browse="false"
                :model-value="newEvent.images"
                multiple
                show-size
                title="Upload Images (up to 25)"
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
                >Add
                </v-btn>
              </v-col>
            </v-row>

          </v-form>
        </div>
      </v-col>
    </v-row>
    </div>
  </v-container>
</template>

<style scoped></style>
