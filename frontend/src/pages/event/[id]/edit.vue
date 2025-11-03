<script setup>
  import { computed, onMounted, reactive, ref } from 'vue'
  import { VueDraggable } from 'vue-draggable-plus'
  import { useRoute, useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import ImageManager from '@/components/ImageManager.vue'
  import PageTitle from '@/components/PageTitle.vue'
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
  const allEventCategories = computed(() =>
    store.state.category.categories.map(item => item.name),
  )

  const storeModule = computed(() => {
    if (route.query.src === 'browse') return 'eventBrowse'
    if (route.query.src === 'wall') return 'eventWall'
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

  async function handleSubmitEditEvent () {
    await form.value.validate()
    if (!isFormValid.value) return

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

    for (const item of newUploads.value) {
      formData.append('files', item)
    }

    store
      .dispatch(`${storeModule.value}/editEvent`, formData)
      .then(() =>
        route.fullPath.includes('browse')
          ? router.push({ name: 'browse' })
          : (route.fullPath.includes('wall')
            ? router.push({ name: 'wall', params: { id: currentUser.value.slug || currentUser.value.id } })
            : null),
      )
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
    newUploads.value = []
    rmImages.value = []
  })
</script>

<template>
  <v-container>
    <page-title subtitle="Update event details" title="Edit Event">
      <v-btn icon="mdi-arrow-left" variant="text" @click="$router.back()" />
    </page-title>

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
            required
            :rules="[
              (v) => !!v || 'Location is required!',
              (v) => (v && v.length <= 50) || 'Must not exceed 50 characters',
            ]"
            variant="solo"
          />

          <v-textarea
            v-model="editingEvent.description"
            class="mt-2"
            clearable
            hide-details="auto"
            label="Description"
            rows="5"
            :rules="[
              (v) => !!v || 'Description is required!',
              (v) =>
                (v && v.length <= 1000) || 'Must not exceed 1000 characters',
            ]"
            variant="solo"
          />
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
                :rules="[(v) => !!v || 'End Time is required!']"
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
              density="comfortable"
              type="info"
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
