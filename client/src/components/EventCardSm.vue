<script setup>
import { formatMonthDate, loadEventThumb, to12hTime } from "@/util";

const { event } = defineProps(["event"]);
</script>

<template>
  <div class="d-flex">
    <v-img
      :aspect-ratio="2"
      :src="loadEventThumb(event?.images?.[0], event?.category)"
      class="flex-grow-0"
      cover
      width="80"
    >
    </v-img>

    <div class="ml-2">
      <h5>{{ event.title }}</h5>

      <div>
        <small
          >{{ formatMonthDate(event.date) }} @{{ to12hTime(event.start_time) }}
          <a
            class="text-primary text-decoration-none clickable"
            @click="
              $router.push({
                name: 'eventSingle',
                params: { id: event.id },
              })
            "
            >more</a
          ></small
        >
      </div>
    </div>
  </div>
</template>

<style scoped></style>
