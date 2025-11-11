<script setup>
  import { computed, onMounted, reactive, ref } from 'vue'
  import { useRouter, useRoute } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import { PasswordReset, User } from '@/models'
  import { isValidEmail, showApiQueryMsg } from '@/others/util'

  definePage({
    name: 'signin', // Set the route name to 'signin'
    meta: {
      layout: 'default',
      title: 'Signin',
      requiresNoAuth: true,
    },
  })

  const { mobile } = useDisplay()
  const store = useStore()
  const router = useRouter()
  const route = useRoute()

  // User model for signin (without password)
  const userInit = new User()
  const user = reactive({ ...userInit })

  // Separate password variable for security
  const password = ref('')

  // Password reset model
  const passwordResetInit = new PasswordReset()
  const passwordReset = reactive({ ...passwordResetInit })

  const calcHome = computed(() => store.getters['auth/calcHome'])

  const visible = ref(false)
  const form = ref(null)
  const isFormValid = ref(true)

  async function signinUser () {
    await form.value.validate()
    if (!isFormValid.value) return

    await store
      .dispatch('auth/signin', {
        email: user.email,
        password: password.value,
      })
      .then(result => {
        // Check if there's a redirect message in localStorage (from friend invitation)
        const apiQueryMsg = localStorage.getItem('apiQueryMsg')
        if (apiQueryMsg && apiQueryMsg.toLowerCase().includes('friend')) {
          // Redirect to friends page if it's a friend invitation message
          // Don't show the message here - let the friends page show it
          router.push({ name: 'friends' })
        } else {
          router.push(calcHome.value)
          // Only show non-friend messages here
          showApiQueryMsg()
        }
      })
  }

  onMounted(() => {
    // Only show non-friend messages on signin page
    // Friend messages should be shown on friends page after login
    const apiQueryMsg = localStorage.getItem('apiQueryMsg')
    if (apiQueryMsg && !apiQueryMsg.toLowerCase().includes('friend')) {
      showApiQueryMsg()
    }
  })

  const dialog = ref(false)
  const resetForm = ref(null)
  const isResetFormValid = ref(true)
  const isRemember = ref(false)

  async function handleSubmitResetPassword () {
    await resetForm.value.validate()
    if (!isResetFormValid.value) return

    store
      .dispatch('user/requestResetPass', { resetEmail: passwordReset.email })
      .then(res => {
        // Reset form after successful request
        Object.assign(passwordReset, passwordResetInit)
        dialog.value = !dialog.value
      })
      .catch(error => {})
  }
</script>

<template>
  <v-container class="fill-height">
    <v-row align="center" justify="center">
      <v-col :cols="12" :lg="6" :md="7" :sm="8">
        <v-card
          class="mx-auto pa-4 pa-md-8 my-2 my-md-4"
          elevation="0"
          max-width="700"
          rounded="lg"
        >
          <v-card-title class="text-center font-weight-bold">
            <h1>Login</h1>
          </v-card-title>
          <v-card-subtitle class="text-center">
            <h2 class="font-weight-regular">Hi, Welcome back 👋</h2>
          </v-card-subtitle>
          <v-card-text>
            <v-form
              ref="form"
              v-model="isFormValid"
              fast-fail
              @submit.prevent="signinUser"
            >
              <!-- Email Address -->
              <v-text-field
                v-model="user.email"
                class="mt-2 mt-md-4"
                clearable
                density="comfortable"
                hide-details="auto"
                label="Email"
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
                :rules="[(v) => !!v || 'Password is required!']"
                :type="visible ? 'text' : 'password'"
                variant="outlined"
                @click:append-inner="visible = !visible"
              />

              <div class="d-flex align-center justify-end my-2">
                <!--                <v-checkbox-->
                <!--                  v-models="isRemember"-->
                <!--                  center-affix-->
                <!--                  color="primary"-->
                <!--                  hide-details="auto"-->
                <!--                  label="Remember me"-->
                <!--                />-->
                <span
                  class="clickable text-secondary mt-1 mt-sm-0 text-center"
                  @click="dialog = !dialog"
                >
                  Forgot Password?
                </span>
              </div>
              <v-btn
                block
                color="primary"
                :density="mobile ? 'comfortable' : 'default'"
                rounded="lg"
                size="large"
                type="submit"
              >
                Login
              </v-btn>
              <div class="text-center mt-2 mt-md-4">
                Not registered yet?
                <v-btn
                  class="clickable"
                  color="primary"
                  density="comfortable"
                  variant="text"
                  @click="
                    router.push({
                      name: 'register',
                    })
                  "
                >
                  Create an account
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

  <v-dialog v-model="dialog" :width="450">
    <v-card class="pa-5">
      <v-card-title class="text-center">
        <h2>Forgot Password?</h2>
      </v-card-title>
      <v-card-subtitle class="text-center text-wrap">
        Please enter the email address you'd like your password reset
        informations sent to
      </v-card-subtitle>
      <v-card-text>
        <v-form
          ref="resetForm"
          v-model="isResetFormValid"
          fast-fail
          @submit.prevent="handleSubmitResetPassword"
        >
          <v-text-field
            v-model="passwordReset.email"
            class="mt-2"
            clearable
            density="comfortable"
            hide-details="auto"
            label="Email"
            rounded="lg"
            :rules="[
              (v) => !!v || 'Email is required!',
              (v) => isValidEmail(v) || 'Invalid Email',
            ]"
            variant="outlined"
          />

          <v-card-actions>
            <v-btn
              block
              class="mx-auto mt-2 mt-md-4"
              color="primary"
              :density="mobile ? 'comfortable' : 'default'"
              rounded="lg"
              size="large"
              type="submit"
              variant="elevated"
            >
              Request reset link
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<style></style>
