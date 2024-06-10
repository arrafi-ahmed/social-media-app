<script setup>
import { useStore } from "vuex";
import { useRoute } from "vue-router";
import { computed, onMounted } from "vue";
import { formatDateFromTimestamp, getBlogImageUrl } from "../util";
import PageTitle from "@/components/PageTitle.vue";

const route = useRoute();
const store = useStore();
const blog = computed(() => store.state.blog.blog);

onMounted(() => {
  store.dispatch("blog/setBlog", route.params.id);
});
</script>
<template>
  <v-container>
    <page-title :title="blog.title">
      <v-btn
        icon="mdi-arrow-left"
        variant="text"
        @click="$router.back()"
      ></v-btn>
    </page-title>

    <!-- Blog Post Content -->
    <v-row class="mt-5" justify="center">
      <v-col cols="12" md="7">
        <v-card v-if="blog.id">
          <v-img
            :src="getBlogImageUrl(blog.image)"
            alt="Blog Post Image"
            aspect-ratio="2.5"
            cover
          ></v-img>
          <v-card-subtitle class="mt-3"
            >Posted on {{ formatDateFromTimestamp(blog.created_at) }}
          </v-card-subtitle>
          <v-card-text class="text-pre-wrap">
            {{ blog.description }}
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
