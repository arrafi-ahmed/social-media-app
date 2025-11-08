<script setup>
  import { computed, nextTick, ref, watch } from 'vue'
  import { useDisplay } from 'vuetify'

  const { imgSet, openingIndex, imgSrc, aspectRatio } = defineProps([
    'imgSet',
    'openingIndex',
    'imgSrc',
    'aspectRatio',
  ])
  const { width, height } = useDisplay()
  const dialog = ref(false)
  const fullSize = ref(false)
  const currIndex = ref(openingIndex)
  const currImg = ref(imgSrc)

  function switchDialog () {
    if (imgSet) {
      currIndex.value = openingIndex
      currImg.value = imgSet[currIndex.value]
    } else {
      currImg.value = imgSrc
    }
    fullSize.value = false
    dialog.value = !dialog.value
  }

  function getPrevImage () {
    if (currIndex.value === 0) return
    currIndex.value = currIndex.value - 1
    currImg.value = imgSet[currIndex.value]
  }

  function getNextImage () {
    if (currIndex.value === imgSet.length - 1) return
    currIndex.value = currIndex.value + 1
    currImg.value = imgSet[currIndex.value]
  }

  const targetImageContainer = ref(null)
  const targetImageWidth = ref(0)
  const targetImageHeight = ref(0)
  const rendered = ref({ width: 0, height: 0 })

  const hasNatural = computed(() => Number(targetImageWidth.value) > 0 && Number(targetImageHeight.value) > 0)
  const targetImageRatio = computed(() => hasNatural.value ? targetImageWidth.value / targetImageHeight.value : undefined)

  async function onImageLoad () {
    await nextTick()
    const imageElement = targetImageContainer.value?.$el.querySelector('img')
    if (!imageElement || !imageElement.complete) {
      imageElement?.addEventListener('load', () => {
        updateImageDimensions(imageElement)
      }, { once: true })
      return
    }
    updateImageDimensions(imageElement)
  }

  function updateImageDimensions (imageElement) {
    targetImageWidth.value = imageElement.naturalWidth
    targetImageHeight.value = imageElement.naturalHeight

    requestAnimationFrame(() => {
      const rect = imageElement.getBoundingClientRect()
      rendered.value = { width: rect.width, height: rect.height }
      console.log('onImageLoad:', {
        ratio: targetImageRatio.value,
        visible: rect,
        clientWidth: imageElement.clientWidth,
        offsetWidth: imageElement.offsetWidth,
        naturalWidth: imageElement.naturalWidth,
        rendered: rendered.value,
      })
    })
  }

  watch(currImg, async () => {
    await nextTick()
    onImageLoad()
  })

  function switchFullsize () {
    fullSize.value = !fullSize.value
  }

  const calcDialogDimension = computed(() => {
    if (!hasNatural.value) {
      return { width: 'auto', height: '90vh', renderedWidth: null, renderedHeight: null }
    }

    if (fullSize.value) {
      // In fullSize mode, use natural dimensions for both dialog and image
      return {
        width: targetImageWidth.value,
        height: targetImageHeight.value,
        renderedWidth: targetImageWidth.value,
        renderedHeight: targetImageHeight.value,
      }
    }

    const maxHeight = height.value * 0.9 // 90vh
    const maxWidth = width.value * 0.9 // 90vw
    const imageRatio = targetImageRatio.value

    let dialogWidth = targetImageWidth.value
    let dialogHeight = targetImageHeight.value

    if (dialogHeight > maxHeight) {
      dialogHeight = maxHeight
      dialogWidth = dialogHeight * imageRatio
    }

    if (dialogWidth > maxWidth) {
      dialogWidth = maxWidth
      dialogHeight = dialogWidth / imageRatio
    }

    const result = {
      width: dialogWidth,
      height: dialogHeight,
      renderedWidth: dialogWidth,
      renderedHeight: dialogHeight,
    }

    console.log('calcDialogDimension:', result)
    return result
  })
</script>

<template>
  <v-img
    :aspect-ratio="aspectRatio || 1.7"
    class="clickable"
    cover
    rounded
    :src="imgSrc"
    @click="switchDialog"
  />

  <v-dialog
    v-model="dialog"
    :fullscreen="fullSize"
    :height="calcDialogDimension.height"
    :scrollable="fullSize"
    :width="calcDialogDimension.width"
  >
    <v-card class="position-relative">
      <v-btn
        :block="false"
        class="z-index-max"
        color="primary"
        icon="mdi-close"
        location="top end"
        :max-width="25"
        position="absolute"
        rounded
        size="sm"
        @click="dialog = !dialog"
      />

      <v-img
        ref="targetImageContainer"
        :aspect-ratio="targetImageRatio"
        :contain="!fullSize"
        :height="calcDialogDimension.renderedHeight || calcDialogDimension.height"
        :src="currImg"
        :width="calcDialogDimension.renderedWidth || calcDialogDimension.width"
        class="mx-auto"
        @click="switchFullsize"
        @load="onImageLoad"
      >
        <v-row
          v-if="imgSet"
          align="center"      class="fill-height ma-0"
          justify="space-between"
      
      >
          <v-col class="d-flex justify-center" cols="auto">
            <v-icon
              v-if="currIndex > 0"
              class="clickable"
              color="grey"
              size="x-large"
              @click.stop="getPrevImage"
            >mdi-chevron-left-circle
            </v-icon>
          </v-col>
          <v-col class="d-flex justify-center" cols="auto">
            <v-icon
              v-if="currIndex < imgSet.length - 1"
              class="clickable"
              color="grey"
              size="x-large"
              @click.stop="getNextImage"
            >mdi-chevron-right-circle
            </v-icon>
          </v-col>
        </v-row>
      </v-img>
    </v-card>
  </v-dialog>
</template>

<style scoped>
.right-0 {
  right: 0 !important;
}

.top-0 {
  top: 0 !important;
}

/* Component-specific styles only */

/* Ensure dialog content can scroll in fullSize mode */
.v-dialog--fullscreen > .v-overlay__content > .v-card {
  overflow: auto !important;
  max-width: none !important;
  max-height: none !important;
}
</style>
