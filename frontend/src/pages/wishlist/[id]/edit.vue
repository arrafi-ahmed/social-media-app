<script setup>
  import { computed, onMounted, reactive, ref } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import ImageManager from '@/components/ImageManager.vue'
  import PageTitle from '@/components/PageTitle.vue'
  import RichTextEditor from '@/components/RichTextEditor.vue'
  import { Wishlist } from '@/models'
  import { getWishlistImageUrl } from '@/others/util.js'

  definePage({
    name: 'wishlistEdit',
    meta: {
      requiresAuth: true,
      title: 'Edit Wishlist',
      layout: 'default',
    },
  })

  const { mobile } = useDisplay()
  const store = useStore()

  const storedEditingEvent = computed(
    () => store.state.eventWishlist.editingEvent,
  )
  const route = useRoute()
  const router = useRouter()

  // Wishlist model for editing
  const wishlistInit = new Wishlist()
  const editingEvent = reactive({ ...wishlistInit })
  const newUploads = ref()
  const rmImages = ref()

  const form = ref(null)
  const isFormValid = ref(true)

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
    await form.value.validate()
    if (!isFormValid.value) return

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

    if (totalCount > 2) {
      isFormValid.value = false
      await store.commit('addSnackbar',
                         { text: `Total images cannot exceed 2! Total Count ${totalCount}`, color: 'error' })
      return
    }

    const formData = new FormData()
    formData.append('id', editingEvent.id)
    formData.append('title', editingEvent.title)
    formData.append('location', editingEvent.location)
    formData.append('description', editingEvent.description)
    formData.append('category', editingEvent.category)
    formData.append('images', JSON.stringify(editingEvent.images))
    formData.append('rmImages', JSON.stringify(rmImages.value))

    for (const item of newUploads.value) {
      formData.append('files', item)
    }
    store.dispatch('eventWishlist/edit', formData).then(() => {
      // Reset form after successful edit
      Object.assign(editingEvent, { ...wishlistInit })
      router.push({ name: 'wishlist' })
    })
  }

  const allEventCategories = computed(() =>
    store.state.category.categories.map(item => item.name),
  )

  onMounted(async () => {
    await store.dispatch('eventWishlist/setEditingEvent', route.params.id)
    await store.dispatch('category/setCategories')

    Object.assign(editingEvent, {
      ...storedEditingEvent.value,
    })
    newUploads.value = []
    rmImages.value = []
  })
</script>

<template>
  <v-container>
    <page-title subtitle="Update wishlist details" title="Edit Wishlist">
      <v-btn icon="mdi-arrow-left" variant="text" @click="$router.back()" />
    </page-title>

    <div class="page-content">
      <v-row align="center" justify="center">
      <v-col cols="12" md="8" sm="10">
        <v-form
          ref="form"
          v-model="isFormValid"
          fast-fail
          @submit.prevent="handleSubmitEditEvent()"
        >
          <v-row>
            <v-col>
              <v-text-field
                v-model="editingEvent.title"
                class="mt-2"
                clearable
                density="compact"
                hide-details="auto"
                label="Title"
                required
                :rules="[
                  (v) => !!v || 'Title is required!',
                  (v) =>
                    (v && v.length <= 50) || 'Must not exceed 50 characters',
                ]"
                variant="solo"
              />

              <v-text-field
                v-model="editingEvent.location"
                class="mt-2"
                clearable
                density="compact"
                hide-details="auto"
                label="Location"
                required
                :rules="[
                  (v) => !!v || 'Location is required!',
                  (v) =>
                    (v && v.length <= 50) || 'Must not exceed 50 characters',
                ]"
                variant="solo"
              />

              <div class="mt-2">
                <label class="text-body-2 text-medium-emphasis mb-2 d-block">Description</label>
                <rich-text-editor
                  v-model="editingEvent.description"
                  placeholder="Describe your wishlist item..."
                />
                <div class="text-caption text-medium-emphasis mt-1">
                  {{ getTextLength(editingEvent.description) }} / 1000 characters
                </div>
              </div>
              <v-select
                v-model="editingEvent.category"
                class="mt-2"
                clearable
                density="compact"
                hide-details
                :items="allEventCategories"
                label="Category"
                required
                :rules="[(v) => !!v || 'Category is required!']"
                variant="solo"
              />
            </v-col>
          </v-row>

          <!-- Display existing images -->
          <div v-if="editingEvent.images?.length > 0" class="images-grid container-border">
            <div
              v-for="(img, index) in editingEvent.images"
              :key="img + '-' + index"
              class="image-item"
            >
              <image-manager
                v-if="img"
                container-class="mt-2 px-2"
                :hide-delete="false"
                max-height="200px"
                max-width="100%"
                :src="getWishlistImageUrl(img)"
                @delete="removeExistingImage(index)"
              />
            </div>
          </div>

          <div class="container-border">
            <v-alert
              class="mt-2"
              density="comfortable"
              type="info"
              variant="tonal"
            >Upload up to 2 images. First selected image will be used as the cover.
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
              title="Upload New Images (up to 2)"
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
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 16px;
}
</style>
