<script setup>
  import { computed, onMounted, ref } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import Applink from '@/components/Applink.vue'
  import Logo from '@/components/Logo.vue'
  import VAnimated from '@/components/v-animated.vue'
  import { formatPrice, getPageImageUrl } from '@/others/util.js'

  definePage({
    name: 'landing',
    meta: {
      requiresNoAuth: true,
      layout: 'headerless',
    },
  })

  const store = useStore()
  const { xs } = useDisplay()
  const router = useRouter()

  const show = ref(false)
  const landing = ref([])
  const initLanding = computed(() => store.state.page.landing)
  const subscriptionPlans = computed(
    () => store.state.subscription.subscriptionPlans,
  )

  onMounted(() => {
    show.value = true
    store.dispatch('page/setPage', 'landing').then(() => {
      landing.value = initLanding.value.description
    })
    store.dispatch('subscription/setSubscriptionPlans')
  })

  // pricing
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

  function handleClickSubscription (plan) {
    router.push({ name: 'register' })
  }

</script>

<template>
  <v-container :class="{ 'text-center': xs }" fluid>
    <v-row justify="center">
      <v-col class="limit-max-width-xl mx-auto" cols="12" md="9">
        <v-row
          align="center"
          class="py-2 mb-3 py-md-15 my-md-15"
          justify="center"
        >
          <v-col cols="11" md="7">
            <v-row :justify="xs ? 'center' : 'start'" no-gutters>
              <v-col cols="8" md="4" sm="6">
                <applink v-if="!xs" />
              </v-col>
            </v-row>

            <v-animated>
              <v-row :justify="xs ? 'center' : 'start'" no-gutters>
                <v-col cols="auto">
                  <logo />
                </v-col>
              </v-row>

              <v-sheet
                v-if="landing[0]?.image"
                class="d-block d-md-none mx-auto mt-8"
                :elevation="8"
              >
                <v-img :src="getPageImageUrl(landing[0]?.image)" />
              </v-sheet>
              <h1 class="mt-3">{{ landing[0]?.title }}</h1>
              <p
                class="mt-2 text-pre-wrap"
                :class="{ 'text-grey-darken-1': xs }"
              >
                {{ landing[0]?.description }}
              </p>
              <div
                class="mt-4 d-block d-md-flex justify-center justify-md-start"
              >
                <v-btn
                  class="text-capitalize ml-1 ml-md-0 mt-1 mt-sm-0"
                  color="secondary"
                  :to="{ name: 'signin' }"
                >Sign in
                </v-btn>
                <v-btn
                  class="text-capitalize ml-sm-5 ml-1 mt-1 mt-sm-0"
                  color="primary"
                  :to="{ name: 'register' }"
                >Join Wayzaway
                </v-btn>
              </div>
            </v-animated>
          </v-col>

          <v-col v-if="landing[0]?.image" class="d-none d-md-block" md="5">
            <v-sheet :elevation="8">
              <v-img :src="getPageImageUrl(landing[0]?.image)" />
            </v-sheet>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col class="limit-max-width-xl mx-auto" cols="12" md="6">
        <v-row
          align="center"
          class="py-5 my-5 py-md-15 my-md-15"
          justify="center"
          justify-md="start"
        >
          <v-col v-if="landing[1]?.image" cols="11" md="6">
            <v-sheet :elevation="8">
              <v-img :src="getPageImageUrl(landing[1]?.image)" />
            </v-sheet>
          </v-col>
          <v-col class="pl-md-6" cols="12" md="6">
            <v-animated>
              <h1>
                {{ landing[1]?.title }}
              </h1>
              <p
                class="mt-2 text-pre-wrap"
                :class="{ 'text-grey-darken-1': xs }"
              >
                {{ landing[1]?.description }}
              </p>
            </v-animated>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col class="limit-max-width-xl mx-auto" cols="12" md="6">
        <v-row
          align="center"
          class="py-5 my-5 py-md-15 my-md-15"
          justify="center"
        >
          <v-col class="pl-md-6" cols="12" md="6">
            <v-animated>
              <h1>{{ landing[2]?.title }}</h1>
              <p
                class="mt-2 text-pre-wrap"
                :class="{ 'text-grey-darken-1': xs }"
              >
                {{ landing[2]?.description }}
              </p>
            </v-animated>
          </v-col>
          <v-col v-if="landing[2]?.image" cols="11" md="6">
            <v-sheet :elevation="8">
              <v-img :src="getPageImageUrl(landing[2]?.image)" />
            </v-sheet>
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-row class="py-5 my-5 py-md-15 my-md-15" justify="center">
      <v-col class="text-center limit-max-width-xl mx-auto" cols="12" md="9">
        <v-animated>
          <v-row justify="center">
            <v-col cols="auto">
              <logo />
            </v-col>
          </v-row>
          <p class="pt-4 text-pre-wrap" :class="{ 'text-grey-darken-1': xs }">
            {{ landing[3]?.description }}
          </p>
        </v-animated>

        <!-- Pricing Content -->
        <v-row class="mt-5" justify="center">
          <v-col cols="12" md="10">
            <v-table v-if="subscriptionPlans.length > 0" class="pa-2">
              <thead>
                <tr>
                  <th class="text-left"><h2>Benefits</h2></th>
                  <template
                    v-for="(item, index) in subscriptionPlans"
                    :key="index"
                  >
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
                              (item.lookupKey === "ultimate_yearly" &&
                                "/year") ||
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
                  <template
                    v-for="(item, index) in subscriptionPlans"
                    :key="index"
                  >
                    <td class="text-center">
                      <v-btn
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
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<style></style>
