<script setup>
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import { computed, onMounted, ref } from "vue";
import PageTitle from "@/components/PageTitle.vue";
import {
  getQueryParam,
  isValidEmail,
  showApiQueryMsg,
  showToast,
} from "@/util";
import { useDisplay } from "vuetify";

const router = useRouter();
const store = useStore();
const { mobile } = useDisplay();

const routeInfo = computed(() => store.state.routeInfo);

const form = ref(null);
const isFormValid = ref(true);

const email = ref(null);
const message = ref(null);

const destination = computed(() =>
  routeInfo.value.from.name === "register"
    ? "pricing"
    : routeInfo.value.from.name === "friends"
    ? "friends"
    : null
);

const sendInvite = async () => {
  await form.value.validate();
  if (!isFormValid.value) return;

  const invitation = {
    email: email.value,
    message: message.value,
  };

  store
    .dispatch("cuser/sendInvite", invitation)
    .then((result) => {
      email.value = null;
      message.value = null;
    })
    .then((res) => {
      router.push({
        name: destination.value,
      });
    });
};

onMounted(() => {
  showApiQueryMsg("success");
});
</script>
<template>
  <v-container>
    <page-title title="Invite friend"></page-title>

    <v-row justify="center" align="center" class="mt-2 mt-md-4">
      <v-col cols="12" md="6">
        <v-form
          ref="form"
          v-model="isFormValid"
          fast-fail
          @submit.prevent="sendInvite"
        >
          <div>
            <p>
              Invite friends or family you think would be interested in
              following your journeys, days out and activities. You can invite a
              maximum of 5 at once.
            </p>
          </div>
          <div>
            <v-combobox
              v-model="email"
              :rules="[
                (v) => !!v || 'Email is required!',
                (v) => isValidEmail(v) || 'Invalid Email',
                (v) => v.length <= 5 || 'Max 5',
              ]"
              class="mt-2"
              clearable
              density="compact"
              hide-details="auto"
              label="Recipient Emails"
              required
              variant="solo"
              hint="Separate by enter"
              chips
              multiple
              :items="[]"
            ></v-combobox>

            <v-textarea
              v-model="message"
              class="mt-2"
              clearable
              hide-details="auto"
              label="Message"
              rows="5"
              variant="solo"
            ></v-textarea>
          </div>
          <div class="d-flex justify-space-between mt-5">
            <v-btn
              v-if="destination"
              :to="{ name: destination }"
              color="primary"
              variant="text"
              >Skip
            </v-btn>
            <v-btn
              :density="mobile ? 'comfortable' : 'default'"
              color="primary"
              type="submit"
              >Submit
            </v-btn>
          </div>
        </v-form>
      </v-col>
    </v-row>
  </v-container>
</template>

<style></style>
