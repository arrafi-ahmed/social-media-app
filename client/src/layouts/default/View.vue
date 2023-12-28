<script setup></script>
<template>
  <v-main>
    <v-container>
      <v-row>
        <v-col class="limit-max-width-xl">
          <router-view />
        </v-col>
      </v-row>
    </v-container>
  </v-main>
</template>
<style>
.limit-max-width-xl {
  max-width: 1400px !important;
  margin: 0 auto;
}
</style>
