<script setup>
import { useDisplay } from "vuetify";
import { getClientPublicImgUrl } from "@/util";

const { customClass } = defineProps(["customClass"]);
const { xs, smAndUp } = useDisplay();
</script>

<template>
  <div
    :class="`d-flex align-center justify-center justify-sm-start mb-3 ${customClass}`"
  >
    <a
      href="https://play.google.com/store/apps/details?id=app.wayzaway.online&pcampaignid=web_share"
      target="_blank"
    >
      <v-img
        width="120"
        height="40"
        :src="getClientPublicImgUrl('badge-google-play.png')"
      ></v-img>
    </a>
    <a
      href="https://apps.apple.com/us/app/wayzaway-lifestyle-journal/id6497877312"
      target="_blank"
    >
      <v-img
        :class="{ 'ml-2': xs, 'ml-3': smAndUp }"
        width="120"
        height="40"
        :src="getClientPublicImgUrl('badge-app-store.png')"
      ></v-img>
    </a>
  </div>
</template>

<style scoped></style>
