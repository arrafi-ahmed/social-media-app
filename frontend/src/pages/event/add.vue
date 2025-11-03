<script setup>
  import { computed, onMounted, reactive, ref } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import PageTitle from '@/components/PageTitle.vue'
  import TimePicker from '@/components/TimePicker.vue'
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

  async function addEvent () {
    if (!isSubscriptionValid.value) {
      return router.push({ name: 'pricing' })
    }

    await form.value.validate()
    if (!isFormValid.value) return

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
      router.push({ name: 'wall', params: { id: currentUser.slug || currentUser.id } })
    })
  }

  onMounted(async () => {
    await store.dispatch('subscription/fetchPremiumSubscriptionData', {
      userId: currentUser.id,
    })
    if (!isSubscriptionValid.value) {
      return router.push({ name: 'pricing' })
    }
    Object.assign(newEvent, { ...eventInit, selectedCategory: null, images: [] })
    await store.dispatch('category/setCategories')
  })
</script>

<template>
  <v-container>
    <page-title subtitle="Create a new event" title="Add Event">
      <v-btn icon="mdi-arrow-left" variant="text" @click="$router.back()" />
    </page-title>
    <v-row align="center" justify="center">
      <v-col cols="12" md="8" sm="10">
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

            <v-textarea
              v-model="newEvent.description"
              class="mt-2 text-pre-wrap"
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
  </v-container>
</template>

<style scoped></style>
