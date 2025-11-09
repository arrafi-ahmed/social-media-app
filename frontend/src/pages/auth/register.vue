<script setup>
  import { onMounted, reactive, ref } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import User from '@/models/user.js'
  import { isValidEmail, isValidPass, showApiQueryMsg } from '@/others/util.js'

  definePage({
    name: 'register',
    meta: {
      requiresNoAuth: true,
      title: 'Register',
      layout: 'default',
    },
  })

  const store = useStore()
  const router = useRouter()
  const { xs } = useDisplay()

  const userInit = new User()
  const user = reactive({ ...userInit })

  // Separate password variables for security
  const password = ref('')
  const confirmPassword = ref('')
  const visible = ref(false)

  const form = ref(null)
  const isFormValid = ref(true)
  const isSubmitting = ref(false)

  async function registerUser () {
    await form.value.validate()
    if (!isFormValid.value || isSubmitting.value) return
    isSubmitting.value = true
    try {
      const response = await $axios.post('/auth/register', {
        ...user,
        password: password.value,
      })
      const payload = response?.data?.payload || {}

      const newFriendsCount = payload.newFriendsCount
      if (newFriendsCount) {
        store.commit('addSnackbar', {
          text: `You've accepted ${newFriendsCount} new friend invitation!`,
          color: 'success',
        })
      }

      // set authentication
      store.commit('auth/setToken', response?.headers?.authorization)
      store.commit('auth/setCurrentUser', payload.currentUser)

      // Welcome event is already created on the backend, just add it to store
      if (payload.welcomeEvent) {
        store.commit('eventWall/addEvent', payload.welcomeEvent)
      }

      // Reset form after successful registration
      Object.assign(user, userInit)
      router.push({ name: 'friendsInvite', params: { ref: 'register' } })
    } catch (error) {
      const message = error?.response?.data?.message || 'Registration failed!'
    // store.commit("addSnackbar", {text: message, color: "error"});
    } finally {
      isSubmitting.value = false
    }
  }

  onMounted(() => {
    showApiQueryMsg()
  })
</script>
<template>
  <v-container class="fill-height">
    <v-row
      align="center"
      justify="center"
    >
      <v-col
        :cols="12"
        :lg="6"
        :md="6"
        :sm="6"
      >
        <v-card
          class="mx-auto pa-4 pa-md-8 my-2 my-md-5"
          elevation="0"
          max-width="600"
          rounded="lg"
        >
          <v-card-title class="text-center font-weight-bold">
            <h1>Register</h1>
          </v-card-title>
          <v-card-subtitle class="text-center">
            <!--            <h2 class="font-weight-regular">Hi, Welcome back 👋</h2>-->
          </v-card-subtitle>
          <v-card-text>
            <v-form
              ref="form"
              v-model="isFormValid"
              fast-fail
              @submit.prevent="registerUser"
            >
              <!-- Full Name -->
              <v-text-field
                v-model="user.fullName"
                class="mt-2"
                clearable
                density="comfortable"
                hide-details="auto"
                label="Name"
                required
                rounded="lg"
                :rules="[
                  (v) => !!v || 'Name is required!',
                  (v) =>
                    (v && v.length <= 50) || 'Must not exceed 50 characters',
                ]"
                variant="outlined"
              />

              <!-- Email Address -->
              <v-text-field
                v-model="user.email"
                class="mt-2 mt-md-4"
                clearable
                density="comfortable"
                hide-details="auto"
                label="Email Address"
                required
                rounded="lg"
                :rules="[
                  (v) => !!v || 'Email is required!',
                  (v) => isValidEmail(v) || 'Invalid Email',
                ]"
                variant="outlined"
              />

              <!-- Password -->
              <v-text-field
                v-model="password"
                :append-inner-icon="visible ? 'mdi-eye-off' : 'mdi-eye'"
                class="mt-2 mt-md-4"
                clearable
                density="comfortable"
                hide-details="auto"
                label="Password"
                required
                rounded="lg"
                :rules="isValidPass"
                :type="visible ? 'text' : 'password'"
                variant="outlined"
                @click:append-inner="visible = !visible"
              />
              <v-text-field
                v-model="confirmPassword"
                :append-inner-icon="visible ? 'mdi-eye-off' : 'mdi-eye'"
                class="mt-2 mt-md-4"
                clearable
                density="comfortable"
                hide-details="auto"
                label="Confirm Password"
                required
                rounded="lg"
                :rules="[
                  (v) => !!v || 'Confirm Password is required!',
                  (v) =>
                    v === password || 'Confirm password didn\'t match!',
                ]"
                :type="visible ? 'text' : 'password'"
                variant="outlined"
                @click:append-inner="visible = !visible"
              />

              <!-- Register Button -->
              <v-btn
                block
                class="mt-2 mt-md-4"
                color="primary"
                :density="xs ? 'comfortable' : 'default'"
                rounded="lg"
                size="large"
                type="submit"
              >
                Register
              </v-btn>

              <div class="text-center text-caption my-2">
                <span>Sign up to see photos from friends and family only</span>
              </div>

              <div class="mt-2 mt-md-4 text-center">
                <v-btn
                  class="clickable"
                  color="primary"
                  density="comfortable"
                  variant="text"
                  @click="router.push({ name: 'signin' })"
                >
                  Already registered?
                </v-btn>
              </div>
              <div class="text-center mt-4">
                <a
                  href="https://apps.apple.com"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="mx-2"
                >
                  <img
                    alt="Download on the App Store"
                    src="/img/badge-app-store.png"
                    style="height: 40px; width: auto;"
                  />
                </a>
                <a
                  href="https://play.google.com"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="mx-2"
                >
                  <img
                    alt="Get it on Google Play"
                    src="/img/badge-google-play.png"
                    style="height: 40px; width: auto;"
                  />
                </a>
              </div>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<style></style>
