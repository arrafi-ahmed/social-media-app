<script setup>
import { getEventImageUrl } from "@/util";
import { ref } from "vue";

const { imgSet, openingIndex, imgSrc, aspectRatio } = defineProps([
  "imgSet",
  "openingIndex",
  "imgSrc",
  "aspectRatio",
]);
const dialog = ref(false);
const fullSize = ref(false);
const currIndex = ref(openingIndex);
const currImg = ref(imgSrc);

const switchDialog = () => {
  // if imgSet is set, prev/next button enabled
  if (imgSet) {
    currIndex.value = openingIndex;
    currImg.value = imgSet[currIndex.value];
  } else {
    currImg.value = imgSrc;
  }

  fullSize.value = false;
  dialog.value = !dialog.value;
};
const getPrevImage = () => {
  if (currIndex.value === 0) return;
  currIndex.value = currIndex.value - 1;
  currImg.value = imgSet[currIndex.value];
};
const getNextImage = () => {
  if (currIndex.value === imgSet.length - 1) return;
  currIndex.value = currIndex.value + 1;
  currImg.value = imgSet[currIndex.value];
};
const targetImageContainer = ref(null);
const targetImageWidth = ref(null);
const targetImageHeight = ref(null);

const onImageLoad = () => {
  const imageElement = targetImageContainer.value?.$el.querySelector("img");
  if (imageElement) {
    targetImageWidth.value = imageElement.naturalWidth;
    targetImageHeight.value = imageElement.naturalHeight;
  }
};

const switchFullsize = () => {
  fullSize.value = !fullSize.value;
};
</script>

<template>
  <v-img
    :aspect-ratio="aspectRatio || 1.7"
    :src="getEventImageUrl(imgSrc || null)"
    class="clickable"
    cover
    @click="switchDialog"
  ></v-img>

  <v-dialog v-model="dialog" :max-width="fullSize ? 1000 : targetImageWidth">
    <v-card class="position-relative">
      <v-btn
        :block="false"
        :max-width="20"
        class="rounded-sm z-index-max"
        color="primary"
        icon="mdi-close"
        location="top end"
        position="absolute"
        size="sm"
        @click="dialog = !dialog"
      ></v-btn>

      <!--      <div ref="targetImage">-->
      <v-img
        ref="targetImageContainer"
        :contain="!fullSize"
        :max-height="fullSize ? targetImageHeight : '85vh'"
        :src="getEventImageUrl(currImg || null)"
        @click="switchFullsize"
        @load="onImageLoad"
      >
        <v-row
          v-if="imgSet"
          align="center"
          class="fill-height ma-0"
          justify="space-between"
        >
          <v-col class="d-flex justify-center" cols="auto">
            <v-icon
              v-if="currIndex > 0"
              class="cursor-pointer"
              color="grey"
              size="x-large"
              @click.stop="getPrevImage"
              >mdi-chevron-left-circle
            </v-icon>
          </v-col>
          <v-col class="d-flex justify-center" cols="auto">
            <v-icon
              v-if="currIndex < imgSet.length - 1"
              class="cursor-pointer"
              color="grey"
              size="x-large"
              @click.stop="getNextImage"
              >mdi-chevron-right-circle
            </v-icon>
          </v-col>
        </v-row>
      </v-img>
      <!--      </div>-->
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
</style>
