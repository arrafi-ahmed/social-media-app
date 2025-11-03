<script setup>
  import { appInfo, getToLink } from '@/others/util.js'

  const items = [
    { title: 'Home', to: { name: 'landing' } },
    { title: 'Blog', to: { name: 'blog' } },
    { title: 'About', to: { name: 'pageSlug', params: { pageSlug: 'about' } } },
    { title: 'Pricing', to: { name: 'pricing' } },
    { title: 'T&C', to: { name: 'pageSlug', params: { pageSlug: 'terms' } } },
    {
      title: 'Privacy',
      to: { name: 'pageSlug', params: { pageSlug: 'privacy' } },
    },
  ]
</script>
<template>
  <v-footer class="flex-grow-0 mt-5">
    <v-row justify="center" no-gutters>
      <v-btn
        v-for="(item, index) in items"
        :key="index"
        class="mx-md-2"
        color="primary"
        exact
        rounded
        size="small"
        :to="getToLink(item)"
        variant="text"
      >
        {{ item.title }}
      </v-btn>
      <v-col class="text-center mt-md-1" cols="12">
        <small>
          &copy; {{ new Date().getFullYear() }} —
          <strong> {{ appInfo.name }} </strong> v{{ appInfo.version }}
        </small>
      </v-col>
    </v-row>
  </v-footer>
</template>
