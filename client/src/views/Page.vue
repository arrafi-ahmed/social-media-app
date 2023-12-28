<script setup>
import { computed, onMounted, watch } from "vue";
import { useStore } from "vuex";
import { useRoute } from "vue-router";
import PageTitle from "@/components/PageTitle.vue";

const store = useStore();
const route = useRoute();
const about = computed(() => store.state.page.about);
const terms = computed(() => store.state.page.terms);
const privacy = computed(() => store.state.page.privacy);

const getPageTitle = computed(() => {
  if (route.name === "about") return about.value.title || "About Us";
  else if (route.name === "terms")
    return terms.value.title || "Terms & Condition";
  else if (route.name === "privacy")
    return privacy.value.title || "Privacy Policy";
  else return "Title not available";
});

const getPageDescription = computed(() => {
  if (route.name === "about")
    return about.value.description || "No content available.";
  else if (route.name === "terms")
    return terms.value.description || "No content available.";
  else if (route.name === "privacy")
    return privacy.value.description || "No content available.";
  else return "Page not available";
});

const fetchData = () => {
  if (route.name === "about") {
    store.dispatch("page/setAbout");
  } else if (route.name === "terms") {
    store.dispatch("page/setTerms");
  } else if (route.name === "privacy") {
    store.dispatch("page/setPrivacy");
  }
};
onMounted(() => fetchData());
watch(
  () => route.name,
  () => fetchData()
);
</script>
<template>
  <page-title :title="getPageTitle"></page-title>

  <v-row class="mt-2" justify="center">
    <v-col md="7">
      <v-card>
        <v-card-text class="text-pre-wrap">
          {{ getPageDescription }}
        </v-card-text>
      </v-card>
    </v-col>
  </v-row>
</template>

<style scoped></style>
