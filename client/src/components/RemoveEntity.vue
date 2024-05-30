<script setup>
import { useDisplay } from "vuetify";
import { ref } from "vue";

const { mobile } = useDisplay();
const dialog = ref(false);
const { id, text, btnVariant, customClass, size } = defineProps({
  id: {},
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
    :variant="btnVariant"
    :class="customClass"
    color="primary"
    density="comfortable"
    :size="size || 'small'"
    @click.stop="dialog = !dialog"
  >
    {{ text }}
  </v-btn>
  <v-btn
    :class="customClass"
    v-if="mobile && !text"
    :variant="btnVariant"
    color="primary"
    density="compact"
    icon="mdi-close"
    :size="size || 'small'"
    @click.stop="dialog = !dialog"
  >
  </v-btn>
  <v-btn
    :class="customClass"
    v-if="!mobile"
    :variant="btnVariant"
    color="primary"
    density="default"
    :size="size || 'default'"
    @click.stop="dialog = !dialog"
    >{{ text || "Remove" }}
  </v-btn>
  <v-dialog v-model="dialog" width="400">
    <v-card>
      <v-card-title>
        <span>{{ text || "Remove" }}</span>
      </v-card-title>
      <v-card-text> Are you sure?</v-card-text>
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
