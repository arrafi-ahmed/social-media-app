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
        :src="getClientPublicImgUrl('badge-google-play.png')"
        height="40"
        width="120"
      ></v-img>
    </a>
    <a
      href="https://apps.apple.com/us/app/wayzaway-lifestyle-journal/id6497877312"
      target="_blank"
    >
      <v-img
        :class="{ 'ml-2': xs, 'ml-3': smAndUp }"
        :src="getClientPublicImgUrl('badge-app-store.png')"
        height="40"
        width="120"
      ></v-img>
    </a>
  </div>
</template>

<style scoped></style>
