<script setup>
  import { computed, onMounted } from 'vue'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import NoItems from '@/components/NoItems.vue'
  import PageTitle from '@/components/PageTitle.vue'
  import { formatDateFromTimestamp, getBlogImageUrl } from '@/others/util.js'

  definePage({
    name: 'blog',
    meta: {
      layout: 'default',
      title: 'Blog',
    },
  })

  const { mobile } = useDisplay()
  const store = useStore()
  const blogs = computed(() => store.state.blog.blogs)
  const blogSearch = ref('')

  onMounted(() => {
    store.dispatch('blog/setBlogs')
  })
</script>
<template>
  <v-container>
    <page-title subtitle="Read our latest stories" title="Blog" />

    <!-- Blog Post List -->
    <v-row class="mt-2" justify="center">
      <v-col cols="12" md="7">
        <v-data-iterator
          v-if="blogs?.length > 0"
          :items="blogs"
          :items-per-page="5"
          :search="blogSearch"
        >
          <template #header>
            <v-text-field
              v-model="blogSearch"
              class="mb-5"
              clearable
              hide-details
              placeholder="Search blogs"
              prepend-inner-icon="mdi-magnify"
              variant="solo"
            />
          </template>

          <template #default="{ items }">
            <v-card v-for="({ raw: item }, index) in items" :key="item.id ?? index" class="mb-5">
              <v-img
                v-if="item.image"
                aspect-ratio="2.5"
                cover
                :src="getBlogImageUrl(item.image)"
              />
              <v-card-title class="mt-3">{{ item.title }}</v-card-title>
              <v-card-subtitle>Posted on
                {{ formatDateFromTimestamp(item.createdAt) }}
              </v-card-subtitle>
              <v-card-text class="text-pre-wrap text-truncate">
                {{ item.description }}
              </v-card-text>
              <v-card-actions>
                <v-btn
                  color="primary"
                  :density="mobile ? 'compact' : 'default'"
                  text
                  :to="{ name: 'blogSingle', params: { id: item.id } }"
                >Read More
                </v-btn>
              </v-card-actions>
            </v-card>
          </template>

          <template #footer="{ page, pageCount, setPage }">
            <v-pagination
              density="compact"
              :length="pageCount"
              :model-value="page"
              :total-visible="3"
              @update:model-value="setPage"
            />
          </template>
        </v-data-iterator>
        <no-items
          v-else
          :closable="false"
          description="There are no blog posts available at the moment."
          icon="mdi-post"
          title="No blogs found"
        />
      </v-col>
    </v-row>

  </v-container>
</template>

<style scoped></style>
