<script setup>
  import { computed, onMounted } from 'vue'
  import { useRoute } from 'vue-router'
  import { useStore } from 'vuex'
  import PageTitle from '@/components/PageTitle.vue'
  import { formatDateFromTimestamp, getBlogImageUrl } from '../../../others/util.js'

  definePage({
    name: 'blogSingle',
    meta: {
      layout: 'default',
      title: 'Blog',
    },
  })

  const route = useRoute()
  const store = useStore()
  const blog = computed(() => store.state.blog.blog)

  onMounted(() => {
    store.dispatch('blog/setBlog', route.params.id)
  })
</script>
<template>
  <v-container>
    <page-title :title="blog.title">
      <v-btn icon="mdi-arrow-left" variant="text" @click="$router.back()" />
    </page-title>

    <!-- Blog Post Content -->
    <v-row class="mt-5" justify="center">
      <v-col cols="12" md="7">
        <v-card v-if="blog.id">
          <v-img
            alt="Blog Post Image"
            aspect-ratio="2.5"
            cover
            :src="getBlogImageUrl(blog.image)"
          />
          <v-card-subtitle class="mt-3">Posted on {{ formatDateFromTimestamp(blog.createdAt) }}
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
