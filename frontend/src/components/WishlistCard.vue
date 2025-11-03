<script setup>
  import { useRouter } from 'vue-router'
  import { useStore } from 'vuex'
  import ConfirmationDialog from '@/components/ConfirmationDialog.vue'
  import { to12hTime } from '@/others/util.js'

  const store = useStore()
  const router = useRouter()
  const { event } = defineProps(['event'])

  function deleteEvent (eventId) {
    store.dispatch('eventWishlist/deleteEvent', eventId)
  }

  function goEditEvent (eventId) {
    store.commit(`setScrollY`, window.scrollY)
    router.push({ name: 'wishlistEdit', params: { id: eventId } })
  }

  function goWishlistSingle (eventId) {
    store.commit(`setScrollY`, window.scrollY)
    router.push({ name: 'wishlistSingle', params: { id: eventId } })
  }
</script>

<template>
  <v-sheet
    v-if="event"
    class="position-relative rounded"
    :elevation="3"
  >
    <v-menu :close-on-content-click="false">
      <template #activator="{ props: menuProps }">
        <v-btn
          class="pa-2"
          color="primary"
          icon="mdi-dots-vertical"
          location="top end"
          position="absolute"
          rounded
          size="x-small"
          v-bind="menuProps"
        />
      </template>
      <v-list density="compact">
        <v-list-item
          density="compact"
          link
          @click="() => goEditEvent(event.id)"
        >
          <v-list-item-title>Edit</v-list-item-title>
        </v-list-item>
        <v-divider />
        <confirmation-dialog popup-content="Are you sure?" popup-title="Delete" @confirm="deleteEvent(event.id)">
          <template #activator="{ onClick }">
            <v-list-item class="text-error" density="compact" link @click="onClick">
              <v-list-item-title>Delete</v-list-item-title>
            </v-list-item>
          </template>
        </confirmation-dialog>
      </v-list>
    </v-menu>

    <div class="pa-3">
      <div class="text-primary text-overline">
        {{ event.category }}
      </div>
      <h4 class="mb-2">{{ event.title }}</h4>
      <div v-if="event.startTime" class="d-flex align-center">
        <v-icon class="mr-2" color="primary" size="small">mdi-clock</v-icon>
        <span>{{ to12hTime(event.startTime) }}</span>
        <span v-if="event.endTime"> - {{ to12hTime(event.endTime) }}</span>
      </div>
      <div v-if="event.location" class="d-flex align-center">
        <v-icon
          class="mr-2"
          color="primary"
          size="small"
        >mdi-map-marker
        </v-icon>
        <span>{{ event.location }}</span>
      </div>

      <div class="d-flex justify-space-between">
        <v-btn
          class="mt-4"
          density="comfortable"
          variant="tonal"
          @click="goWishlistSingle(event.id)"
        >More Details
        </v-btn>
      </div>
    </div>
  </v-sheet>
</template>

<style scoped></style>
