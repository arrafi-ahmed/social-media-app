<script setup>
import { useDisplay } from "vuetify";
import { ref } from "vue";

const { mobile } = useDisplay();
const dialog = ref(false);
const { id, message, text, btnVariant, customClass, size } = defineProps({
  id: {},
  message: { default: "Are you sure?" },
  text: {},
  btnVariant: { default: "flat" },
  customClass: {},
  size: {},
});
const emit = defineEmits(["removeEntity"]);

const remove = (id) => {
  if (id) {
    emit("removeEntity", id);
  } else {
    emit("removeEntity");
  }
  dialog.value = false;
};
</script>
<template>
  <v-btn
    v-if="mobile && text"
    :class="customClass"
    :size="size || 'small'"
    :variant="btnVariant"
    color="primary"
    density="comfortable"
    @click.stop="dialog = !dialog"
  >
    {{ text }}
  </v-btn>
  <v-btn
    v-if="mobile && !text"
    :class="customClass"
    :size="size || 'small'"
    :variant="btnVariant"
    color="primary"
    density="compact"
    icon="mdi-close"
    @click.stop="dialog = !dialog"
  >
  </v-btn>
  <v-btn
    v-if="!mobile"
    :class="customClass"
    :size="size || 'default'"
    :variant="btnVariant"
    color="primary"
    density="default"
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
        <v-spacer></v-spacer>
        <v-btn
          :density="mobile ? 'comfortable' : 'default'"
          color="primary"
          @click="remove(id)"
          >Yes
        </v-btn>
        <v-btn
          :density="mobile ? 'comfortable' : 'default'"
          color="primary"
          @click="dialog = !dialog"
          >No
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<style scoped></style>
