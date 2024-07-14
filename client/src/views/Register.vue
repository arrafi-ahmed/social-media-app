<script setup>
import { computed, onMounted, ref } from "vue";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
import Event from "@/model/event";
import {
  formatTimeFromDate,
  getCurrentDate,
  isValidEmail,
  isValidPass,
  showApiQueryMsg,
  showToast,
} from "@/util";
import Cuser from "@/model/cuser";
import { useDisplay } from "vuetify";
import Applink from "@/components/Applink.vue";

const { mobile } = useDisplay();
const store = useStore();
const router = useRouter();
const fullName = ref(null);
const email = ref(null);
const password = ref(null);
const confirmPassword = ref(null);
// const dateOfBirth = ref(new Date());
// const selectedCountry = ref(null);
const form = ref(null);
const isFormValid = ref(true);

const currentUser = computed(() => store.getters["cuser/getCurrentUser"]);

const isValidDOB = (dateOfBirth) => {
  const currentDate = new Date();
  const minDate = new Date();
  minDate.setFullYear(currentDate.getFullYear() - 13);

  const inputDate = new Date(dateOfBirth);
  return inputDate <= minDate;
};

const registerUser = async () => {
  await form.value.validate();
  if (!isFormValid.value) return;

  const cuser = new Cuser(
    fullName.value,
    email.value,
    password.value
    // dateOfBirth.value,
    // selectedCountry.value
  );
  $axios
    .post("/api/user/register", cuser)
    .then((response) => {
      const newFriendsCount = response.data?.payload?.newFriendsCount;
      if (newFriendsCount) {
        showToast(
          `You've accepted ${newFriendsCount} new friend invitation!`,
          "success"
        );
      }

      // set authentication
      store.commit("cuser/setToken", response.headers?.authorization);
      store.commit("cuser/setCurrentUser", response.data?.payload?.currentUser);

      // add event
      const event = new Event(
        "Joined WayzAway!",
        getCurrentDate(),
        formatTimeFromDate(new Date()),
        null,
        null,
        "Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.",
        "Registration",
        null,
        false,
        null
      );

      return store.dispatch("eventWall/addEvent", event);
    })
    .then(() => {
      router.push({
        name: "friends-invite",
        params: { ref: "register" },
      });
    });
};
onMounted(() => {
  showApiQueryMsg();
});
</script>
<template>
  <v-container class="fill-height">
    <v-row align="center" justify="center">
      <v-col cols="12" lg="6" md="6" sm="6">
        <v-card
          class="mx-auto pa-2 my-2"
          color="grey-lighten-3"
          elevation="4"
          max-width="500"
        >
          <v-card-text>
            <v-card-title class="text-center font-weight-bold">
              Register
            </v-card-title>
            <v-form
              ref="form"
              v-model="isFormValid"
              fast-fail
              @submit.prevent="registerUser"
            >
              <!-- Full Name -->
              <v-text-field
                v-model="fullName"
                :rules="[
                  (v) => !!v || 'Full Name is required!',
                  (v) =>
                    (v && v.length <= 50) || 'Must not exceed 50 characters',
                ]"
                class="mt-2 mt-md-4"
                clearable
                density="compact"
                hide-details="auto"
                label="Full Name"
                required
                variant="solo"
              ></v-text-field>

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
                required
                variant="solo"
              ></v-text-field>

              <!-- Retype email-->
              <v-text-field
                :rules="[(v) => v === email || 'Confirm email didn\'t match!']"
                class="mt-2 mt-md-4"
                clearable
                density="compact"
                hide-details="auto"
                label="Confirm Email Address"
                required
                variant="solo"
              ></v-text-field>

              <!-- Password -->
              <v-text-field
                v-model="password"
                :rules="isValidPass"
                class="mt-2 mt-md-4"
                clearable
                density="compact"
                hide-details="auto"
                label="Password"
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
                required
                type="password"
                variant="solo"
              ></v-text-field>

              <!--              <date-picker-->
              <!--                v-model="dateOfBirth"-->
              <!--                :rules="[-->
              <!--                  (v) => !!v || 'DOB is required!',-->
              <!--                  (v) => isValidDOB(v) || 'Must be 13 years old!',-->
              <!--                ]"-->
              <!--                color="primary"-->
              <!--                custom-class="mt-2 mt-md-4"-->
              <!--                label="Date of Birth"-->
              <!--                variant="solo"-->
              <!--              ></date-picker>-->

              <!--              <v-select-->
              <!--                v-model="selectedCountry"-->
              <!--                :items="getCountryList('name')"-->
              <!--                :rules="[(v) => !!v || 'Country is required!']"-->
              <!--                class="mt-2 mt-md-4"-->
              <!--                density="compact"-->
              <!--                hide-details-->
              <!--                label="Country"-->
              <!--                required-->
              <!--                variant="solo"-->
              <!--              ></v-select>-->

              <div class="pb-3 pl-1 mt-3">
                By signing up, you agree to the
                <span
                  class="clickable mt-5 text-center text-blue"
                  @click="router.push({ name: 'terms' })"
                >
                  Terms of Service
                </span>
              </div>

              <!-- Register Button -->
              <v-btn
                :density="mobile ? 'comfortable' : 'default'"
                block
                color="primary"
                @click="registerUser"
                >Register
              </v-btn>
              <div
                class="clickable mt-3 text-center text-blue"
                @click="router.push({ name: 'signin' })"
              >
                Already registered?
              </div>
            </v-form>
          </v-card-text>
        </v-card>

        <v-row justify="center" class="mt-2">
          <v-col cols="auto">
            <applink></applink>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<style></style>
