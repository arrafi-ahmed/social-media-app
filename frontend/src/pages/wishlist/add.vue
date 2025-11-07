<script setup>
  import { computed, onMounted, reactive, ref } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import PageTitle from '@/components/PageTitle.vue'
  import RichTextEditor from '@/components/RichTextEditor.vue'
  import { Wishlist } from '@/models'

  definePage({
    name: 'wishlistAdd',
    meta: {
      requiresAuth: true,
      title: 'Add Wishlist',
      layout: 'default',
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

  const form = ref(null)
  const isFormValid = ref(true)

  // Wishlist model for adding new wishlist item
  const wishlistInit = new Wishlist()
  const newEvent = reactive({ ...wishlistInit })

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

    // If we're here, it's an addition - append new files (max 2 for wishlist)
    newEvent.images.push(...files)
  }

  // Helper to strip HTML tags and get text length for validation
  function getTextLength (html) {
    if (!html) return 0
    const temp = document.createElement('div')
    temp.innerHTML = html
    return (temp.textContent || temp.innerText || '').length
  }

  async function addNewEvent () {
    if (!isSubscriptionValid.value) {
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

    if (imageCount > 2) {
      isFormValid.value = false
      await store.commit('addSnackbar',
                         { text: `Total images cannot exceed 2! Total Count ${imageCount}`, color: 'error' })
      return
    }

    const formData = new FormData()
    formData.append('title', newEvent.title)
    formData.append('location', newEvent.location)
    formData.append('description', newEvent.description)
    formData.append('category', newEvent.selectedCategory)
    for (const file of newEvent.images) {
      formData.append('files', file)
    }

    store.dispatch('eventWishlist/save', formData).then(() => {
      // Reset form after successful addition
      Object.assign(newEvent, {
        ...wishlistInit,
        selectedCategory: null,
        images: [],
      })
      router.push({ name: 'wishlist' })
    })
  }

  const allEventCategories = computed(() =>
    store.state.category.categories.map(item => item.name),
  )
  onMounted(async () => {
    await store.dispatch('subscription/fetchPremiumSubscriptionData', {
      userId: currentUser.id,
    })
    if (!isSubscriptionValid.value) {
      return router.push({ name: 'pricing' })
    }
    Object.assign(newEvent, { ...wishlistInit, selectedCategory: null, images: [] })
    await store.dispatch('category/setCategories')
  })
</script>

<template>
  <v-container>
    <page-title subtitle="Add to your wishlist" title="Add Wishlist">
      <v-btn icon="mdi-arrow-left" variant="text" @click="$router.back()" />
    </page-title>
    <div class="page-content">
      <v-row align="center" justify="center">
        <v-col cols="12" md="8" sm="10">
          <div>
            <v-form
              ref="form"
              v-model="isFormValid"
              fast-fail
              @submit.prevent="addNewEvent"
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
                  placeholder="Describe your wishlist item..."
                />
                <div class="text-caption text-medium-emphasis mt-1">
                  {{ getTextLength(newEvent.description) }} / 1000 characters
                </div>
              </div>

              <v-select
                v-model="newEvent.selectedCategory"
                class="mt-2"
                clearable
                hide-details
                :items="allEventCategories"
                label="Category"
                :rules="[(v) => !!v || 'Category is required!']"
                variant="solo"
              />

              <div class="container-border">
                <v-file-upload
                  accept="image/*"
                  class="mt-2"
                  clearable
                  density="compact"
                  :hide-browse="false"
                  :model-value="newEvent.images"
                  multiple
                  show-size
                  title="Upload Images (up to 2)"
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
