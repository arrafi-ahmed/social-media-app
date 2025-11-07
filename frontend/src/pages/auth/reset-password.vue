<script setup>
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import PageTitle from '@/components/PageTitle.vue'
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
      <v-col cols="12" md="4">
        <page-title subtitle="Set a new password" title="Reset Password" />
        <div class="page-content">
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
                  class="mt-2 mt-md-4"
                  clearable
                  density="compact"
                  hide-details="auto"
                  label="Password"
                  prepend-inner-icon="mdi-lock"
                  required
                  :rules="isValidPass"
                  type="password"
                  variant="solo"
                />
                <v-text-field
                  v-model="confirmPassword"
                  class="mt-2 mt-md-4"
                  clearable
                  density="compact"
                  hide-details="auto"
                  label="Confirm Password"
                  prepend-inner-icon="mdi-lock"
                  required
                  :rules="[
                    (v) => !!v || 'Confirm Password is required!',
                    (v) => v === password || 'Confirm password didn\'t match!',
                  ]"
                  type="password"
                  variant="solo"
                />

                <div class="d-flex align-center mt-2 mt-md-5">
                  <div
                    class="clickable text-center text-blue"
                    @click="router.push({ name: 'signin' })"
                  >
                    Sign in
                  </div>
                  <v-spacer />
                  <v-btn
                    color="primary"
                    :density="mobile ? 'comfortable' : 'default'"
                    type="submit"
                  >Submit
                  </v-btn>
                </div>
              </v-form>
            </v-card-text>
          </v-card>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<style></style>
