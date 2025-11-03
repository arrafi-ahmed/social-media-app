<script setup>
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

    <v-row class="mt-2" justify="center">
      <v-col md="9">
        <v-row v-if="pageSlug === 'about'" justify="start" no-gutters>
          <v-col cols="8" md="4" sm="6">
            <applink />
          </v-col>
        </v-row>

        <v-card v-if="currentState?.description?.content">
          <v-card-text class="text-pre-wrap">
            {{ currentState.description.content }}
          </v-card-text>
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
  </v-container>
</template>

<style scoped></style>
