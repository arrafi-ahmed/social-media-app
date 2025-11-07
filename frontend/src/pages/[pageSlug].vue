<script setup>
  import DOMPurify from 'dompurify'
  import { computed, onMounted, watch } from 'vue'
  import { useRoute } from 'vue-router'
  import { useStore } from 'vuex'
  import Applink from '@/components/Applink.vue'
  import NoItems from '@/components/NoItems.vue'
  import PageTitle from '@/components/PageTitle.vue'

  definePage({
    name: 'pageSlug',
    meta: {
      layout: 'default',
    },
  })

  const store = useStore()
  const route = useRoute()
  const pageSlug = computed(() => route.params.pageSlug)

  const calcHome = computed(() => store.getters['auth/calcHome'])

  const pageTitles = {
    about: 'About Us',
    terms: 'Terms & Condition',
    privacy: 'Privacy Policy',
  }

  const pageSubtitles = {
    about: 'Learn more about WayzAway',
    terms: 'Our terms and conditions',
    privacy: 'Your privacy matters to us',
  }

  const currentState = computed(() => store.state.page[pageSlug.value] || {})
  const currentTitle = computed(() => pageTitles[pageSlug.value] || 'Page')
  const currentSubtitle = computed(() => pageSubtitles[pageSlug.value] || '')

  // Get sanitized HTML content
  const sanitizedContent = computed(() => {
    const content = currentState.value?.description?.content || currentState.value?.description || ''
    if (!content) return ''

    // Check if content contains HTML tags (from rich editor)
    const hasHtmlTags = /<[a-z][\s\S]*>/i.test(content)

    if (hasHtmlTags) {
      // Sanitize HTML content
      return DOMPurify.sanitize(content, {
        ALLOWED_TAGS: ['p', 'br', 'strong', 'em', 'u', 'h1', 'h2', 'h3', 'ul', 'ol', 'li', 'a'],
        ALLOWED_ATTR: ['href', 'target', 'rel'],
        ALLOW_DATA_ATTR: false,
      })
    } else {
      // Plain text content - convert newlines to <br> and escape HTML
      const escaped = content
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
      return escaped.replace(/\n/g, '<br>')
    }
  })

  // Check if content exists
  const hasContent = computed(() => {
    const content = currentState.value?.description?.content || currentState.value?.description || ''
    return !!content
  })

  async function fetchData () {
    if (pageSlug.value) {
      await store.dispatch('page/setPage', pageSlug.value)
    }
  }

  onMounted(async () => await fetchData())
  watch(
    () => pageSlug.value,
    () => fetchData(),
  )
</script>
<template>
  <v-container>
    <page-title :back-url="calcHome" :subtitle="currentSubtitle" :title="currentTitle || 'Title not available'" />

    <div class="page-content">
      <v-row justify="center">
        <v-col md="9">
          <v-row v-if="pageSlug === 'about'" justify="start" no-gutters>
            <v-col cols="8" md="4" sm="6">
              <applink />
            </v-col>
          </v-row>

          <v-card v-if="hasContent">
            <v-card-text
              class="rich-text-content"
              v-html="sanitizedContent"
            />
          </v-card>
          <no-items
            v-else
            :closable="false"
            description="This page doesn't have any content yet."
            icon="mdi-file-document-outline"
            title="No content available"
          />
        </v-col>
      </v-row>
    </div>
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

.rich-text-content :deep(strong) {
  font-weight: 600;
}

.rich-text-content :deep(em) {
  font-style: italic;
}

.rich-text-content :deep(u) {
  text-decoration: underline;
}
</style>
