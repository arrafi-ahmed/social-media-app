<script setup>
  import { computed, onMounted, ref } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import ConfirmationDialog from '@/components/ConfirmationDialog.vue'
  import NoItems from '@/components/NoItems.vue'
  import PageTitle from '@/components/PageTitle.vue'
  import { formatPrice, handleRemoveQueriesNRedirect } from '@/others/util.js'

  definePage({
    name: 'pricing',
    meta: {
      title: 'Pricing',
      layout: 'default',
    },
  })

  const router = useRouter()
  const store = useStore()
  const { mobile } = useDisplay()

  const subscription = computed(() => store.state.subscription.subscription)
  const subscriptionPlans = computed(
    () => store.state.subscription.subscriptionPlans,
  )
  const isSubscriptionActive = computed(
    () => store.getters['subscription/isSubscriptionActive'],
  )
  const pendingCancel = computed(
    () => store.getters['subscription/pendingCancel'],
  )

  function isPlanSelected (planId) {
    return isSubscriptionActive.value && subscription.value.planId === planId
  }

  const benefits = ref([
    {
      title: 'Create Posts',
      ultimate: 'Unlimited',
      standard: 'Unlimited',
      basic: '5/month',
    },
    {
      title: 'Create a Wishlist',
      ultimate: true,
      standard: true,
      basic: false,
    },
    {
      title: 'Tag Favourites',
      ultimate: true,
      standard: true,
      basic: true,
    },
    {
      title: 'Comment on other Posts',
      ultimate: true,
      standard: true,
      basic: true,
    },
  ])
  const signedin = computed(() => store.getters['auth/signedin'])

  function handleClickSubscription (plan) {
    if (!signedin.value) {
      router.push({ name: 'register' })
    }
    store.commit('setProgress', true)
    store
      .dispatch('subscription/saveSubscription', plan)
      .then(result => {
        window.location.href = result.url
      })
      .finally(() => store.commit('setProgress', false))
  }

  function handleClickSubscriptionCancel (stripeSubscriptionId) {
    store.dispatch('subscription/cancelSubscription', {
      stripeSubscriptionId,
      instantCancel: false,
    })
  }

  const routeInfo = computed(() => store.state.routeInfo)
  const showContinue = ref(false)
  const showBack = computed(
    () =>
      routeInfo.value?.from?.name !== undefined
      && routeInfo.value?.from?.name !== 'friendsInvite',
  )

  function processSuccessQueryParam () {
    handleRemoveQueriesNRedirect({ params: ['subscription_success'], hardRedirect: false })
    const isSubscriptionSucceeded = localStorage.getItem('subscription_success')
    if (isSubscriptionSucceeded === '1') {
      localStorage.removeItem('subscription_success')
      showContinue.value = true

      store.commit('addSnackbar', {
        text: 'Subscription activated!',
        color: 'success',
      })
    }
  }

  const currentUser = store.getters['auth/getCurrentUser']
  onMounted(async () => {
    processSuccessQueryParam()
    await store.dispatch('subscription/setSubscription', currentUser.id)
    await store.dispatch('subscription/setSubscriptionPlans')
  })
</script>
<template>
  <v-container>
    <page-title subtitle="Choose your plan" title="Pricing">
      <v-btn
        v-if="showBack"
        icon="mdi-arrow-left"
        variant="text"
        @click="$router.back()"
      />
    </page-title>

    <div class="page-content">
      <!-- Pricing Content -->
      <v-row justify="center">
        <v-col cols="12" md="10">
          <v-table v-if="subscriptionPlans.length > 0" class="mt-5 pa-4">
            <thead>
              <tr>
                <th class="text-left"><h2>Benefits</h2></th>
                <template v-for="(item, index) in subscriptionPlans" :key="index">
                  <th class="text-center vertical-baseline">
                    <div>
                      <div
                        class="pa-2"
                        :class="
                          item.title.toLowerCase() === 'basic'
                            ? 'bg-secondary'
                            : 'bg-primary'
                        "
                      >
                        <h2>{{ item.title }}</h2>
                      </div>
                      <div class="my-3 mt-2">
                        <h3>
                          {{ formatPrice(item.price, item.currency) }}{{
                            (item.lookupKey === "ultimate_yearly" && "/year") ||
                              (item.lookupKey === "standard_monthly" &&
                                "/month") ||
                              (item.lookupKey === "basic_free" && "")
                          }}
                        </h3>
                        <small>{{ item.tagline }}</small>
                      </div>
                    </div>
                  </th>
                </template>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in benefits" :key="item.title">
                <td class="text-start">{{ item.title }}</td>
                <td class="text-center">
                  <template v-if="typeof item.ultimate === 'string'">
                    <span class="text-success font-weight-bold">{{ item.ultimate }}</span>
                  </template>
                  <template v-else>
                    <v-icon v-if="item.ultimate" color="success" icon="mdi-check" />
                    <v-icon v-else color="danger" icon="mdi-close" />
                  </template>
                </td>
                <td class="text-center">
                  <template v-if="typeof item.standard === 'string'">
                    <span class="text-success font-weight-bold">{{ item.standard }}</span>
                  </template>
                  <template v-else>
                    <v-icon v-if="item.standard" color="success" icon="mdi-check" />
                    <v-icon v-else color="error" icon="mdi-close" />
                  </template>
                </td>
                <td class="text-center">
                  <template v-if="typeof item.basic === 'string'">
                    <span class="text-success font-weight-bold">{{ item.basic }}</span>
                  </template>
                  <template v-else>
                    <v-icon v-if="item.basic" color="success" icon="mdi-check" />
                    <v-icon v-else color="error" icon="mdi-close" />
                  </template>
                </td>
              </tr>
              <tr>
                <td />
                <template v-for="(item, index) in subscriptionPlans" :key="index">
                  <td class="text-center">
                    <template v-if="isPlanSelected(item.id)">
                      <div class="bg-primary mx-1 my-2 pa-2 rounded">
                        <div class="text-button text-white">Active</div>
                        <confirmation-dialog
                          popup-content="Are you sure you want to cancel your subscription?"
                          popup-title="Cancel subscription"
                          @confirm="handleClickSubscriptionCancel(subscription.stripeSubscriptionId)"
                        >
                          <template #activator="{ onClick }">
                            <v-btn
                              class="mt-2 text-white"
                              :disabled="pendingCancel"
                              rounded-sm
                              variant="outlined"
                              @click="onClick"
                            >{{ (pendingCancel && "Cancelled") || "Cancel" }}
                            </v-btn>
                          </template>
                        </confirmation-dialog>
                        <div v-if="pendingCancel && item.title !== 'basic'">
                          Expiring @
                          {{ subscription.expireDate.slice(0, 10) }}
                        </div>
                      </div>
                    </template>
                    <v-btn
                      v-else
                      color="primary"
                      rounded-sm
                      variant="outlined"
                      @click="handleClickSubscription(item)"
                    >Select
                    </v-btn>
                  </td>
                </template>
              </tr>
            </tbody>
          </v-table>
          <no-items
            v-if="subscriptionPlans.length === 0"
            action-icon="mdi-calendar-search"
            action-text="Explore Events"
            :closable="false"
            description="Please check back later for available subscription plans."
            :full-page="true"
            icon="mdi-credit-card-outline"
            :show-action="true"
            title="No subscription plans available"
            @action="$router.push({ name: 'browse' })"
          />
        </v-col>
      </v-row>
      <v-row justify="center">
        <v-col cols="auto">
          <v-btn
            v-if="showContinue"
            class="text-center"
            color="primary"
            :density="mobile ? 'comfortable' : 'default'"
            :to="{ name: 'wall', params: { id: currentUser.slug || currentUser.id } }"
          >Continue
          </v-btn>
        </v-col>
      </v-row>
    </div>
  </v-container>
</template>

<style></style>
