<script setup>
import { computed, ref } from "vue";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
import { isValidEmail, showApiQueryMsg } from "@/util";
import { useDisplay } from "vuetify";

const { mobile } = useDisplay();
const store = useStore();
const router = useRouter();

const email = ref(null);
const password = ref(null);
const currentUser = computed(() => store.getters["cuser/getCurrentUser"]);

const form = ref(null);
const isFormValid = ref(true);

const signinUser = async () => {
  await form.value.validate();
  if (!isFormValid.value) return;

  store
    .dispatch("cuser/signin", {
      email: email.value,
      password: password.value,
    })
    .then((result) => {
      if (currentUser.value.role === "user") {
        return router.push({
          name: "browse",
        });
      } else if (currentUser.value.role === "admin") {
        return router.push({
          name: "adminDashboard",
        });
      }
    })
    .then((result) => {
      showApiQueryMsg("success");
    })
    .catch((err) => {});
};
let dialog = ref(false);
const resetEmail = ref(null);
const resetForm = ref(null);
const isResetFormValid = ref(true);

const handleSubmitResetPassword = async () => {
  await resetForm.value.validate();
  if (!isResetFormValid.value) return;

  store.dispatch("cuser/requestResetPass", resetEmail.value).then(() => {
    dialog.value = !dialog.value;
  });
};
</script>

<template>
  <v-container class="fill-height">
    <v-row align="center" justify="center">
      <v-col cols="12" lg="6" md="6" sm="6">
        <v-card
          class="mx-auto pa-4 pa-md-8 my-2 my-md-5"
          color="grey-lighten-3"
          elevation="2"
          max-width="400"
        >
          <v-card-title class="text-center font-weight-bold">
            Sign In
          </v-card-title>
          <v-card-text>
            <v-form
              ref="form"
              v-model="isFormValid"
              fast-fail
              @submit.prevent="signinUser"
            >
              <!-- Email Address -->
              <v-text-field
                v-model="email"
                :rules="[
                  (v) => !!v || 'Email is required!',
                  (v) => isValidEmail(v) || 'Invalid Email',
                ]"
                class="mt-2 mt-md-4"
                clearable
                density="compact"
                hide-details="auto"
                label="Email Address"
                prepend-inner-icon="mdi-account"
                required
                variant="solo"
              ></v-text-field>

              <!-- Password -->
              <v-text-field
                v-model="password"
                :rules="[(v) => !!v || 'Password is required!']"
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

              <div class="d-flex align-center mt-2 mt-md-5">
                <div>
                  <div
                    class="clickable text-blue"
                    @click="router.push({ name: 'register' })"
                  >
                    No Account?
                  </div>
                  <div class="clickable text-blue" @click="dialog = !dialog">
                    Forgot Password?
                  </div>
                </div>
                <v-spacer></v-spacer>
                <v-btn
                  :density="mobile ? 'comfortable' : 'default'"
                  color="primary"
                  type="submit"
                  >Sign In
                </v-btn>
              </div>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>

  <v-dialog v-model="dialog" width="350">
    <v-card>
      <v-card-title>
        <span>Reset Password</span>
      </v-card-title>
      <v-card-text>
        <v-form
          ref="resetForm"
          v-model="isResetFormValid"
          fast-fail
          @submit.prevent="handleSubmitResetPassword"
        >
          <v-text-field
            v-model="resetEmail"
            :rules="[
              (v) => !!v || 'Email is required!',
              (v) => isValidEmail || 'Invalid Email',
            ]"
            class="mt-2"
            clearable
            density="compact"
            hide-details="auto"
            label="Email"
            variant="solo"
          ></v-text-field>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              :density="mobile ? 'compact' : 'default'"
              color="primary"
              type="submit"
              >Submit
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<style></style>
