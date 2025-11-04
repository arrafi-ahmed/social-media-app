<script setup>
  import { computed, onMounted } from 'vue'
  import { useRoute } from 'vue-router'
  import { useStore } from 'vuex'
  import DOMPurify from 'dompurify'
  import PageTitle from '@/components/PageTitle.vue'
  import { formatDateFromTimestamp, getBlogImageUrl } from '../../../others/util.js'

  // Helper to check if content is HTML and sanitize it
  function getSanitizedDescription(html) {
    if (!html) return ''
    // Check if content contains HTML tags (from rich editor)
    const hasHtmlTags = /<[a-z][\s\S]*>/i.test(html)
    if (hasHtmlTags) {
      return DOMPurify.sanitize(html, {
        ALLOWED_TAGS: ['p', 'br', 'strong', 'em', 'u', 'h1', 'h2', 'h3', 'ul', 'ol', 'li', 'a'],
        ALLOWED_ATTR: ['href', 'target', 'rel'],
        ALLOW_DATA_ATTR: false
      })
    }
    // Plain text - escape HTML and convert newlines to <br>
    const escaped = html
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
    return escaped.replace(/\n/g, '<br>')
  }

  const sanitizedDescription = computed(() => getSanitizedDescription(blog.value?.description))

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
          <v-card-text
            class="rich-text-content"
            v-html="sanitizedDescription"
          />
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped>
.rich-text-content {
  line-height: 1.6;
}

.rich-text-content :deep(h1),
.rich-text-content :deep(h2),
.rich-text-content :deep(h3) {
  font-weight: 600;
  line-height: 1.2;
  margin-top: 1em;
  margin-bottom: 0.5em;
}

.rich-text-content :deep(h1) {
  font-size: 2em;
}

.rich-text-content :deep(h2) {
  font-size: 1.5em;
}

.rich-text-content :deep(h3) {
  font-size: 1.25em;
}

.rich-text-content :deep(p) {
  margin-bottom: 0.75em;
}

.rich-text-content :deep(ul),
.rich-text-content :deep(ol) {
  padding-left: 1.5em;
  margin-bottom: 0.75em;
}

.rich-text-content :deep(ul) {
  list-style-type: disc;
}

.rich-text-content :deep(ol) {
  list-style-type: decimal;
}

.rich-text-content :deep(li) {
  margin-bottom: 0.25em;
}

.rich-text-content :deep(a) {
  color: rgb(var(--v-theme-primary));
  text-decoration: underline;
}

.rich-text-content :deep(a:hover) {
  opacity: 0.8;
}
</style>
