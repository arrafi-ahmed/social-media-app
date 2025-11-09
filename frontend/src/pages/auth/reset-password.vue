<script setup>
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import { getQueryParam, isValidPass } from '@/others/util.js'

  definePage({
    name: 'resetPassword',
    meta: {
      requiresNoAuth: true,
      title: 'Reset Password',
      layout: 'default',
    },
  })

  const { mobile } = useDisplay()
  const store = useStore()
  const router = useRouter()

  const password = ref(null)
  const confirmPassword = ref(null)
  const visible = ref(false)
  const visibleConfirm = ref(false)

  const form = ref(null)
  const isFormValid = ref(true)

  async function handleSubmitResetPassword () {
    await form.value.validate()
    if (!isFormValid.value) return

    store
      .dispatch('user/submitResetPass', {
        newPass: password.value,
        token: getQueryParam({ param: 'token' }),
      })
      .then(res => {
        router.push({
          name: 'signin',
        })
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
            <h1>Reset Password</h1>
          </v-card-title>
          <v-card-subtitle class="text-center">
            <h2 class="font-weight-regular">Set a new password 🔒</h2>
          </v-card-subtitle>
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

              <!-- Confirm Password -->
              <v-text-field
                v-model="confirmPassword"
                :append-inner-icon="visibleConfirm ? 'mdi-eye-off' : 'mdi-eye'"
                class="mt-2 mt-md-4"
                clearable
                density="comfortable"
                hide-details="auto"
                label="Confirm Password"
                required
                rounded="lg"
                :rules="[
                  (v) => !!v || 'Confirm Password is required!',
                  (v) => v === password || 'Confirm password didn\'t match!',
                ]"
                :type="visibleConfirm ? 'text' : 'password'"
                variant="outlined"
                @click:append-inner="visibleConfirm = !visibleConfirm"
              />

              <div class="d-flex align-center justify-end my-2">
                <span
                  class="clickable text-secondary mt-1 mt-sm-0 text-center"
                  @click="router.push({ name: 'signin' })"
                >
                  Back to Sign in
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
                Reset Password
              </v-btn>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<style></style>
