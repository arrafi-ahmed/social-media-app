<script setup>
import Logo from "@/components/Logo.vue";
import { useDisplay } from "vuetify";
import { computed, onMounted, reactive, ref } from "vue";
import VAnimated from "@/components/v-animated.vue";
import { useStore } from "vuex";
import { getPageImageUrl } from "@/util";
import Applink from "@/components/Applink.vue";

const initLanding = computed(() => store.state.page.landing);
const landing = reactive([
  { title: null, description: null, image: null },
  { title: null, description: null, image: null },
  { title: null, description: null, image: null },
  { title: null, description: null, image: null },
]);

const store = useStore();
const { xs } = useDisplay();
const show = ref(false);

onMounted(() => {
  show.value = true;
  store.dispatch("page/setLanding").then(() => {
    if (initLanding.value) {
      const parsedDescription = JSON.parse(initLanding.value.description);
      Object.assign(landing, {
        ...parsedDescription,
      });
    }
  });
});
</script>

<template>
  <v-container :class="{ 'text-center': xs }" fluid>
    <v-row class="bg-grey-lighten-3" justify="center">
      <v-col class="limit-max-width-xl mx-auto" cols="12" md="9">
        <v-row
          align="center"
          class="py-2 mb-3 py-md-15 my-md-15"
          justify="center"
        >
          <v-col cols="11" md="7">
            <v-row :justify="xs ? 'center' : 'start'" no-gutters>
              <v-col cols="8" md="4" sm="6">
                <applink></applink>
              </v-col>
            </v-row>

            <v-animated>
              <v-row :justify="xs ? 'center' : 'start'" no-gutters>
                <v-col cols="auto">
                  <logo />
                </v-col>
              </v-row>

              <v-sheet
                v-if="landing[0].image"
                :elevation="8"
                class="d-block d-md-none mx-auto mt-8"
              >
                <v-img :src="getPageImageUrl(landing[0].image)"></v-img>
              </v-sheet>
              <h1 class="mt-3">{{ landing[0].title }}</h1>
              <p
                :class="{ 'text-grey-darken-1': xs }"
                class="mt-2 text-pre-wrap"
              >
                {{ landing[0].description }}
              </p>
              <div
                class="mt-4 d-block d-md-flex justify-center justify-md-start"
              >
                <v-btn
                  :to="{ name: 'signin' }"
                  class="text-capitalize ml-1 ml-md-0 mt-1 mt-sm-0"
                  color="secondary"
                  >Sign in
                </v-btn>
                <v-btn
                  :to="{ name: 'register' }"
                  class="text-capitalize ml-sm-5 ml-1 mt-1 mt-sm-0"
                  color="primary"
                  >Join Wayzaway
                </v-btn>
              </div>
            </v-animated>
          </v-col>

          <v-col v-if="landing[0].image" class="d-none d-md-block" md="5">
            <v-sheet :elevation="8">
              <v-img :src="getPageImageUrl(landing[0].image)"></v-img>
            </v-sheet>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row class="bg-white" justify="center">
      <v-col class="limit-max-width-xl mx-auto" cols="12" md="6">
        <v-row
          align="center"
          class="py-5 my-5 py-md-15 my-md-15"
          justify="center"
          justify-md="start"
        >
          <v-col v-if="landing[1].image" cols="11" md="6">
            <v-sheet :elevation="8">
              <v-img :src="getPageImageUrl(landing[1].image)"></v-img>
            </v-sheet>
          </v-col>
          <v-col class="pl-md-6" cols="12" md="6">
            <v-animated>
              <h1>
                {{ landing[1].title }}
              </h1>
              <p
                :class="{ 'text-grey-darken-1': xs }"
                class="mt-2 text-pre-wrap"
              >
                {{ landing[1].description }}
              </p>
            </v-animated>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row class="bg-grey-lighten-3" justify="center">
      <v-col class="limit-max-width-xl mx-auto" cols="12" md="6">
        <v-row
          align="center"
          class="py-5 my-5 py-md-15 my-md-15"
          justify="center"
        >
          <v-col class="pl-md-6" cols="12" md="6">
            <v-animated>
              <h1>{{ landing[2].title }}</h1>
              <p
                :class="{ 'text-grey-darken-1': xs }"
                class="mt-2 text-pre-wrap"
              >
                {{ landing[2].description }}
              </p>
            </v-animated>
          </v-col>
          <v-col v-if="landing[2].image" cols="11" md="6">
            <v-sheet :elevation="8">
              <v-img :src="getPageImageUrl(landing[2].image)"></v-img>
            </v-sheet>
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-row class="py-5 my-5 py-md-15 my-md-15 bg-white" justify="center">
      <v-col class="text-center limit-max-width-xl mx-auto" cols="12" md="9">
        <v-animated>
          <v-row justify="center">
            <v-col cols="auto">
              <logo />
            </v-col>
          </v-row>
          <p :class="{ 'text-grey-darken-1': xs }" class="pt-4 text-pre-wrap">
            {{ landing[3].description }}
          </p>
        </v-animated>
        <v-row v-if="landing[3].image" justify="center">
          <v-col class="my-5" cols="11" xl="5">
            <v-sheet :elevation="8">
              <v-img :src="getPageImageUrl(landing[3].image)"></v-img>
            </v-sheet>
          </v-col>
        </v-row>
        <h4>Are you ready?</h4>
        <div class="mt-4">
          <v-btn
            :to="{ name: 'signin' }"
            class="text-capitalize mt-2 mt-sm-0"
            color="primary"
            >Sign in
          </v-btn>
          <v-btn
            :to="{ name: 'register' }"
            class="text-capitalize ml-2 mt-2 mt-sm-0"
            color="secondary"
            >Join Wayzaway
          </v-btn>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
