<script setup></script>
<template>
  <v-main>
    <div class="fill-height limit-max-width-xl mx-auto">
      <router-view />
    </div>
  </v-main>
</template>
<style>
.limit-max-width-xl {
  max-width: 1400px !important;
}
</style>
