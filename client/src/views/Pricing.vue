<script setup>
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import { computed, onMounted, ref } from "vue";
import PageTitle from "@/components/PageTitle.vue";
import { getQueryParam, showToast } from "@/util";
import { useDisplay } from "vuetify";

const router = useRouter();
const store = useStore();
const { mobile } = useDisplay();

const subscription = computed(() => store.state.subscription.subscription);
const subscriptionPlans = computed(
  () => store.state.subscription.subscriptionPlans
);
const isSubscriptionActive = computed(
  () => store.getters["subscription/isSubscriptionActive"]
);
const pendingCancel = computed(
  () => store.getters["subscription/pendingCancel"]
);
const isPlanSelected = (planId) =>
  isSubscriptionActive.value && subscription.value.plan_id === planId;

const benefits = ref([
  {
    title: "Create Posts",
    ultimate: true,
    standard: true,
    basic: false,
  },
  {
    title: "Create a Wishlist",
    ultimate: true,
    standard: true,
    basic: false,
  },
  {
    title: "Tag Favourites",
    ultimate: true,
    standard: true,
    basic: true,
  },
  {
    title: "Comment on other Posts",
    ultimate: true,
    standard: true,
    basic: true,
  },
]);
const signedin = computed(() => store.getters["cuser/signedin"]);

const handleClickSubscription = (plan) => {
  if (!signedin.value) {
    router.push({ name: "register" });
  }
  store.commit("setProgress", true);
  store
    .dispatch("subscription/saveSubscription", plan)
    .then((result) => {
      window.location.href = result.url;
      if (plan.title.toLowerCase() === "basic") {
        processSuccessQueryParam(); // show action success notif for basic
      }
    })
    .finally(() => store.commit("setProgress", false));
};
const handleClickSubscriptionCancel = (stripeSubscriptionId) => {
  store.dispatch("subscription/cancelSubscription", {
    stripeSubscriptionId,
    instantCancel: false,
  });
};
const showContinue = ref(false);
const processSuccessQueryParam = () => {
  const isSubscriptionSucceeded = getQueryParam("subscription_success");
  if (isSubscriptionSucceeded === "1") {
    showContinue.value = true;
    showToast("Subscription activated!", "success");
  }
};
const currentUser = store.getters["cuser/getCurrentUser"];
onMounted(async () => {
  processSuccessQueryParam();
  await store.dispatch("subscription/setSubscription", currentUser.id);
  await store.dispatch("subscription/setSubscriptionPlans");
});
</script>
<template>
  <v-container>
    <page-title title="Pricing">
      <v-btn
        icon="mdi-arrow-left"
        variant="text"
        @click="$router.back()"
      ></v-btn>
    </page-title>

    <!-- Pricing Content -->
    <v-row class="mt-5" justify="center">
      <v-col cols="12" md="10">
        <v-table v-if="subscriptionPlans.length > 0">
          <thead>
            <tr>
              <th class="text-left"><h2>Benefits</h2></th>
              <template v-for="(item, index) in subscriptionPlans" :key="index">
                <th class="text-center vertical-baseline">
                  <div>
                    <div
                      :class="
                        item.title.toLowerCase() === 'basic'
                          ? 'bg-secondary'
                          : 'bg-primary'
                      "
                      class="pa-2"
                    >
                      <h2>{{ item.title }}</h2>
                    </div>
                    <div class="my-3 mt-2">
                      <h3>
                        £{{ item.price
                        }}{{
                          (item.title.toLowerCase() == "ultimate" && "/year") ||
                          (item.title.toLowerCase() == "standard" &&
                            "/month") ||
                          (item.title.toLowerCase() == "basic" && "")
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
                <v-icon
                  v-if="item.ultimate"
                  color="success"
                  icon="mdi-check"
                ></v-icon>
                <v-icon v-else color="danger" icon="mdi-close"></v-icon>
              </td>
              <td class="text-center">
                <v-icon
                  v-if="item.standard"
                  color="success"
                  icon="mdi-check"
                ></v-icon>
                <v-icon v-else color="error" icon="mdi-close"></v-icon>
              </td>
              <td class="text-center">
                <v-icon
                  v-if="item.basic"
                  color="success"
                  icon="mdi-check"
                ></v-icon>
                <v-icon v-else color="error" icon="mdi-close"></v-icon>
              </td>
            </tr>
            <tr>
              <td></td>
              <template v-for="(item, index) in subscriptionPlans" :key="index">
                <td class="text-center">
                  <template v-if="isPlanSelected(item.id)">
                    <div class="bg-primary mx-1 my-2 pa-2 rounded">
                      <div class="text-button text-white">Active</div>
                      <v-btn
                        :disabled="pendingCancel"
                        class="bg-white"
                        color="primary"
                        rounded-sm
                        variant="outlined"
                        @click="
                          handleClickSubscriptionCancel(
                            subscription.stripe_subscription_id
                          )
                        "
                        >{{ (pendingCancel && "Cancelled") || "Cancel" }}
                      </v-btn>
                      <div v-if="pendingCancel && item.title !== 'basic'">
                        Expiring @
                        {{ subscription.expire_date.slice(0, 10) }}
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
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="auto">
        <v-btn
          v-if="showContinue"
          :to="{ name: 'wall', params: { id: currentUser.id } }"
          color="primary"
          :density="mobile ? 'comfortable' : 'default'"
          class="text-center"
          >Continue
        </v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<style>
.vertical-baseline {
  vertical-align: baseline !important;
}
</style>
