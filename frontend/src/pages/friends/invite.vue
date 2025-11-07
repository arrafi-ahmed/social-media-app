<script setup>
  import { computed, onMounted, ref } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import PageTitle from '@/components/PageTitle.vue'
  import { isValidEmail, showApiQueryMsg } from '@/others/util.js'

  definePage({
    name: 'friendsInvite',
    meta: {
      requiresAuth: true,
      title: 'Invite Friends',
      layout: 'default',
    },
  })

  const router = useRouter()
  const store = useStore()
  const { mobile } = useDisplay()

  const routeInfo = computed(() => store.state.routeInfo)

  const form = ref(null)
  const isFormValid = ref(true)

  const email = ref(null)
  const message = ref(null)

  const destination = computed(() =>
    routeInfo.value.from.name === 'register'
      ? 'pricing'
      : (routeInfo.value.from.name === 'friends'
        ? 'friends'
        : null),
  )

  async function sendInvite () {
    await form.value.validate()
    if (!isFormValid.value) return

    const invitation = {
      email: email.value,
      message: message.value,
    }

    store
      .dispatch('user/sendInvite', invitation)
      .then(result => {
        email.value = null
        message.value = null
      })
      .then(res => {
        router.push({
          name: destination.value,
        })
      })
  }

  onMounted(() => {
    showApiQueryMsg('success')
  })
</script>
<template>
  <v-container>
    <page-title title="Invite friend" />

    <div class="page-content">
      <v-row align="center" justify="center">
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
                chips
                class="mt-2"
                clearable
                density="compact"
                hide-details="auto"
                hint="Separate by enter"
                :items="[]"
                label="Recipient Emails"
                multiple
                required
                :rules="[
                  (v) => !!v || 'Email is required!',
                  (v) => isValidEmail(v) || 'Invalid Email',
                  (v) => v.length <= 5 || 'Max 5',
                ]"
                variant="solo"
              />

              <v-textarea
                v-model="message"
                class="mt-2"
                clearable
                hide-details="auto"
                label="Message"
                rows="5"
                variant="solo"
              />
            </div>
            <div class="d-flex justify-space-between mt-5">
              <v-btn
                v-if="destination"
                color="primary"
                :to="{ name: destination }"
                variant="text"
              >Skip
              </v-btn>
              <v-btn
                color="primary"
                :density="mobile ? 'comfortable' : 'default'"
                type="submit"
              >Submit
              </v-btn>
            </div>
          </v-form>
        </v-col>
      </v-row>
    </div>
  </v-container>
</template>

<style></style>
