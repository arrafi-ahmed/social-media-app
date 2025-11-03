<script setup>
  import { ref } from 'vue'
  import { useDisplay } from 'vuetify'

  const { mobile } = useDisplay()
  const dialog = ref(false)
  const { id, message, text, btnVariant, customClass, size } = defineProps({
    id: {},
    message: { default: 'Are you sure?' },
    text: {},
    btnVariant: { default: 'flat' },
    customClass: {},
    size: {},
  })
  const emit = defineEmits(['removeEntity'])

  function remove (id) {
    if (id) {
      emit('removeEntity', id)
    } else {
      emit('removeEntity')
    }
    dialog.value = false
  }
</script>
<template>
  <v-btn
    v-if="mobile && text"
    :class="customClass"
    color="primary"
    density="comfortable"
    :size="size || 'small'"
    :variant="btnVariant"
    @click.stop="dialog = !dialog"
  >
    {{ text }}
  </v-btn>
  <v-btn
    v-if="mobile && !text"
    :class="customClass"
    color="primary"
    density="compact"
    icon="mdi-close"
    :size="size || 'small'"
    :variant="btnVariant"
    @click.stop="dialog = !dialog"
  />
  <v-btn
    v-if="!mobile"
    :class="customClass"
    color="primary"
    density="default"
    :size="size || 'default'"
    :variant="btnVariant"
    @click.stop="dialog = !dialog"
  >{{ text || "Remove" }}
  </v-btn>
  <v-dialog v-model="dialog" width="400">
    <v-card>
      <v-card-title>
        <span>{{ text || "Remove" }}</span>
      </v-card-title>
      <v-card-text>{{ message }}</v-card-text>
      <v-card-actions>
        <v-spacer />
        <v-btn
          color="primary"
          :density="mobile ? 'comfortable' : 'default'"
          @click="remove(id)"
        >Yes
        </v-btn>
        <v-btn
          color="primary"
          :density="mobile ? 'comfortable' : 'default'"
          @click="dialog = !dialog"
        >No
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<style scoped></style>
