<script setup>
import Logo from "@/components/Logo.vue";
import { useDisplay } from "vuetify";
import { getClientPublicImgUrl } from "@/util";
import { computed, onMounted, reactive, ref } from "vue";
import VAnimated from "@/components/v-animated.vue";
import { useStore } from "vuex";

const initLanding = computed(() => store.state.page.landing);
const landing = reactive({
  title: ["", "", ""],
  description: ["", "", "", ""],
});

const store = useStore();
const { mobile } = useDisplay();
const show = ref(false);

onMounted(() => {
  show.value = true;
  store.dispatch("page/setLanding").then(() => {
    landing.title = JSON.parse(initLanding.value.title);
    landing.description = JSON.parse(initLanding.value.description);
  });
});
</script>

<template>
  <v-container :class="{ 'text-center': mobile }" fluid>
    <v-row class="bg-grey-lighten-3" justify="center">
      <v-col cols="12" md="8">
        <v-row
          align="center"
          class="py-2 mb-3 py-md-15 my-md-15"
          justify="center"
        >
          <v-col cols="12" md="8">
            <v-animated>
              <logo />
              <v-img
                :src="getClientPublicImgUrl('people.png')"
                class="d-block d-md-none w-50 mx-auto mt-8"
              ></v-img>
              <h1 class="mt-3">{{ landing.title[0] }}</h1>
              <p
                :class="{ 'text-grey-darken-1': mobile }"
                class="mt-2 text-pre-wrap"
              >
                {{ landing.description[0] }}
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

          <v-col class="d-none d-md-block" md="4">
            <v-img :src="getClientPublicImgUrl('people.png')"></v-img>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row class="bg-white" justify="center">
      <v-col cols="12" md="6">
        <v-row
          align="center"
          class="py-5 my-5 py-md-15 my-md-15"
          justify="center"
          justify-md="start"
        >
          <v-col cols="6" md="6">
            <v-img :src="getClientPublicImgUrl('motorhome.png')"></v-img>
          </v-col>
          <v-col class="pl-md-6" cols="12" md="6">
            <v-animated>
              <h1>
                {{ landing.title[1] }}
              </h1>
              <p
                :class="{ 'text-grey-darken-1': mobile }"
                class="mt-2 text-pre-wrap"
              >
                {{ landing.description[1] }}
              </p>
            </v-animated>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row class="bg-grey-lighten-3" justify="center">
      <v-col cols="12" md="6">
        <v-row
          align="center"
          class="py-5 my-5 py-md-15 my-md-15"
          justify="center"
        >
          <v-col class="pl-md-6" cols="12" md="6">
            <v-animated>
              <h1>{{ landing.title[2] }}</h1>
              <p
                :class="{ 'text-grey-darken-1': mobile }"
                class="mt-2 text-pre-wrap"
              >
                {{ landing.description[2] }}
              </p>
            </v-animated>
          </v-col>
          <v-col cols="5" md="6">
            <v-img :src="getClientPublicImgUrl('confetti.png')"></v-img>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row class="py-5 my-5 py-md-15 my-md-15 bg-white" justify="center">
      <v-col class="text-center" cols="12" md="10">
        <v-animated>
          <v-row justify="center">
            <v-col cols="auto">
              <logo />
            </v-col>
          </v-row>
          <p
            :class="{ 'text-grey-darken-1': mobile }"
            class="pt-4 text-pre-wrap"
          >
            {{ landing.description[3] }}
          </p>
        </v-animated>
        <v-row justify="center">
          <v-col cols="6" md="4">
            <v-img :src="getClientPublicImgUrl('beach-sunset.png')"></v-img>
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
