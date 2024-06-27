<script setup>
import { getToLink } from "@/util";

const items = [
  { title: "Home", to: { name: "landing" } },
  { title: "Blog", to: { name: "blog" } },
  { title: "About", to: { name: "about" } },
  { title: "Pricing", to: { name: "pricing" } },
  { title: "T&C", to: { name: "terms" } },
  { title: "Privacy", to: { name: "privacy" } },
];
</script>
<template>
  <v-footer class="bg-grey-lighten-3 flex-grow-0 mt-5">
    <v-row justify="center" no-gutters>
      <v-btn
        v-for="(item, index) in items"
        :key="index"
        :to="getToLink(item)"
        class="mx-md-2"
        color="primary"
        exact
        rounded
        size="small"
        variant="text"
      >
        {{ item.title }}
      </v-btn>
      <v-col class="text-center mt-md-1" cols="12">
        <small>
          &copy; {{ new Date().getFullYear() }} — <strong>WayzAway</strong> v1.5
        </small>
      </v-col>
    </v-row>
  </v-footer>
</template>
