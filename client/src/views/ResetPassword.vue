<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
import { getQueryParam, isValidPass } from "@/util";
import PageTitle from "@/components/PageTitle.vue";
import { useDisplay } from "vuetify";

const { mobile } = useDisplay();
const store = useStore();
const router = useRouter();

const password = ref(null);
const confirmPassword = ref(null);

const form = ref(null);
const isFormValid = ref(true);

const handleSubmitResetPassword = async () => {
  await form.value.validate();
  if (!isFormValid.value) return;

  store
    .dispatch("cuser/submitResetPass", {
      newPass: password.value,
      token: getQueryParam("token"),
    })
    .then((res) => {
      router.push({
        name: "signin",
      });
    })
    .catch((err) => {});
};
</script>

<template>
  <v-container class="fill-height">
    <v-row align="center" justify="center">
      <v-col cols="12" md="4">
        <page-title justify="center" title="Reset Password"></page-title>
        <v-card
          class="mx-auto pa-2 pa-md-5 my-2 my-md-5"
          color="grey-lighten-3"
          elevation="4"
          max-width="500"
        >
          <v-card-text>
            <v-form
              ref="form"
              v-model="isFormValid"
              fast-fail
              @submit.prevent="handleSubmitResetPassword"
            >
              <!-- Password -->
              <v-text-field
                v-model="password"
                :rules="isValidPass"
                class="mt-2 mt-md-4"
                clearable
                density="compact"
                hide-details="auto"
                label="Password"
                prepend-inner-icon="mdi-lock"
                required
                type="password"
                variant="solo"
              ></v-text-field>
              <v-text-field
                v-model="confirmPassword"
                :rules="[
                  (v) => !!v || 'Confirm Password is required!',
                  (v) => v === password || 'Confirm password didn\'t match!',
                ]"
                class="mt-2 mt-md-4"
                clearable
                density="compact"
                hide-details="auto"
                label="Confirm Password"
                prepend-inner-icon="mdi-lock"
                required
                type="password"
                variant="solo"
              ></v-text-field>

              <div class="d-flex align-center mt-2 mt-md-5">
                <div
                  class="clickable text-center text-blue"
                  @click="router.push({ name: 'signin' })"
                >
                  Sign in
                </div>
                <v-spacer></v-spacer>
                <v-btn
                  :density="mobile ? 'comfortable' : 'default'"
                  color="primary"
                  type="submit"
                  >Submit
                </v-btn>
              </div>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<style></style>
