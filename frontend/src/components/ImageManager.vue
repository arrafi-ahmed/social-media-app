<script setup>
  import { computed, nextTick, ref } from 'vue'
  import ConfirmationDialog from '@/components/ConfirmationDialog.vue'

  const {
    src,
    maxHeight = '200px',
    maxWidth,
    aspectRatio = '16/9',
    containerClass,
    hideDelete,
  } = defineProps({
    src: {
      type: String,
      default: null,
    },
    maxHeight: {
      type: String,
      default: '200px',
    },
    maxWidth: {
      type: String,
    },
    aspectRatio: {
      type: String,
      default: '16/9',
    },
    containerClass: {
      type: String,
    },
    hideDelete: {
      type: Boolean,
      default: false,
    },
  })

  const emit = defineEmits(['delete'])

  const isDeleted = ref(false)
  const imageDimensions = ref({ width: 0, height: 0 })
  const imageRef = ref(null)

  const hasImage = computed(() => {
    return src && src !== 'null' && src.trim() !== '' && !isDeleted.value
  })

  const imageStyle = computed(() => {
    const { width, height } = imageDimensions.value

    if (width === 0 || height === 0) {
      // Default size if dimensions not loaded yet
      return {
        width: maxWidth || '300px',
        height: maxHeight || '225px',
      }
    }

    const aspectRatio = width / height
    let containerWidth, containerHeight

    if (aspectRatio > 1.5) {
      // Wide/horizontal image
      containerWidth = maxWidth || '350px'
      containerHeight = maxHeight || '200px'
    } else if (aspectRatio < 0.7) {
      // Tall/vertical image
      containerWidth = maxWidth || '250px'
      containerHeight = maxHeight || '350px'
    } else {
      // Square-ish image
      containerWidth = maxWidth || '300px'
      containerHeight = maxHeight || '225px'
    }

    return {
      width: containerWidth,
      height: containerHeight,
    }
  })

  const placeholderStyle = computed(() => {
    const { width, height } = imageStyle.value
    return {
      width,
      height,
      background: '#f5f5f5',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      borderRadius: '8px',
    }
  })

  function handleDelete () {
    isDeleted.value = true
    emit('delete')
  }

  function onImageLoad (event) {
    // Try to get dimensions from event.target first
    if (event && event.target && event.target.naturalWidth && event.target.naturalHeight) {
      const { naturalWidth, naturalHeight } = event.target
      imageDimensions.value = { width: naturalWidth, height: naturalHeight }
      return
    }

    // Fallback: try to get dimensions from the image ref
    nextTick(() => {
      if (imageRef.value && imageRef.value.$el) {
        const imgElement = imageRef.value.$el.querySelector('img')
        if (imgElement && imgElement.naturalWidth && imgElement.naturalHeight) {
          imageDimensions.value = {
            width: imgElement.naturalWidth,
            height: imgElement.naturalHeight,
          }
        }
      }
    })
  }

  function onImageError (error) {
    console.error('Image failed to load:', error)
  }
</script>

<template>
  <div v-if="hasImage" :class="`image-preview-container ${containerClass || ''}`">
    <div class="image-preview border border-4 rounded-lg">
      <v-img
        ref="imageRef"
        alt="Preview"
        class="rounded-lg preview-image"
        cover
        :src="src"
        :style="imageStyle"
        @error="onImageError"
        @load="onImageLoad"
      />

      <!-- Delete Button -->
      <confirmation-dialog v-if="!hideDelete" @confirm="handleDelete">
        <template #activator="{ onClick }">
          <v-btn
            class="delete-btn no-drag d-flex align-center justify-center clickable"
            color="error"
            size="x-small"
            title="Delete Image"
            variant="flat"
            @click.stop="onClick"
          >
            <v-icon size="20">mdi-delete</v-icon>
          </v-btn>
        </template>
      </confirmation-dialog>
    </div>
  </div>

  <!-- Deleted State Placeholder -->
  <div v-else-if="isDeleted" class="image-preview-container">
    <div class="image-preview border border-4 rounded-lg" :style="placeholderStyle">
      <div class="placeholder-content">
        <v-icon color="grey-lighten-1" size="48">mdi-image-off</v-icon>
        <p class="text-body-2 text-grey-lighten-1 mt-2">Image deleted</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.image-preview-container {
  position: relative;
  width: 100%;
}

.image-preview {
  position: relative;
  display: block;
  width: 100%;
}

.delete-btn {
  position: absolute !important;
  top: 8px !important;
  right: 8px !important;
  z-index: 2 !important;
  backdrop-filter: blur(4px);
  transition: opacity 0.2s ease;
  opacity: 0.9;
}

.placeholder-content {
  text-align: center;
}
</style>
