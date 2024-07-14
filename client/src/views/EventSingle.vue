<script setup>
import { computed, onMounted, ref } from "vue";
import { useStore } from "vuex";
import { useRoute, useRouter } from "vue-router";
import {
  formatDateFromTimestamp,
  formatTimeFromTime,
  goUserProfile,
} from "@/util";
import { useDisplay } from "vuetify";
import Lightbox from "@/components/Lightbox.vue";
import UserAvatar from "@/components/UserAvatar.vue";

const { xs, mobile } = useDisplay();
const route = useRoute();
const router = useRouter();
const store = useStore();
const event = computed(() => store.state.eventSingle.event);
const newCommentText = ref(null);
const currentUser = computed(() => store.getters["cuser/getCurrentUser"]);

const isAdmin = computed(() => store.getters["cuser/isAdmin"]);
const isOwner = (commenter_id) => commenter_id == currentUser.value.id;

const handleFavoriteEvent = (payload) => {
  store.dispatch("eventSingle/switchFavoriteEvent", {
    eventId: route.params.id,
    payload: !payload,
  });
};

const addComment = () => {
  const newComment = {
    event_id: route.params.id,
    text: newCommentText.value,
    full_name: currentUser.value.name,
    image: currentUser.value.image,
  };
  store.dispatch("eventSingle/addComment", newComment).then((res) => {
    newCommentText.value = null;
    return store.dispatch("eventWall/setEventNotification", {
      eventId: route.params.id,
      payload: true,
    });
  });
};

const deleteComment = (commentId) => {
  store.dispatch("eventSingle/deleteComment", commentId);
};

onMounted(() => {
  store
    .dispatch("eventSingle/getEvent", route.params.id)
    .then((res) => {
      return Promise.all([
        store.dispatch("eventSingle/setIsFavorite", route.params.id),
        store.dispatch("eventSingle/getCommentsByEventId", route.params.id),
      ]);
    })
    .finally(() => {
      if (!event.value.id) {
        router.push({ name: "notFound" });
      }
    });
});
</script>

<template>
  <v-container v-if="event.id">
    <v-row align="center" class="pb-1" justify="space-between">
      <v-col class="d-flex align-center" cols="auto">
        <user-avatar
          :imgSrc="event?.image"
          @click-avatar="goUserProfile(event.user_id)"
        ></user-avatar>

        <div class="pl-3">
          <h4 class="clickable" @click="goUserProfile(event.user_id)">
            {{ event?.full_name }}
          </h4>
          <small
            >Posted on {{ formatDateFromTimestamp(event?.created_at) }}</small
          >
        </div>
      </v-col>
      <v-col cols="auto">
        <v-btn
          icon="mdi-arrow-left"
          variant="text"
          @click="$router.back()"
        ></v-btn>
      </v-col>
    </v-row>

    <v-row justify="center">
      <v-col cols="12" md="8">
        <lightbox
          :key="event?.images?.[0]"
          :aspect-ratio="2.5"
          :img-src="event?.images?.[0]"
        ></lightbox>

        <h2 class="mt-8">{{ event?.title }}</h2>

        <div class="d-flex justify-space-between mt-4">
          <div>
            <div v-if="event?.date" class="d-flex">
              <v-icon class="mt-half" color="primary" size="small"
                >mdi-calendar
              </v-icon>
              <span class="ml-3">{{
                formatDateFromTimestamp(event?.date)
              }}</span>
            </div>
            <div v-if="event?.start_time && event?.end_time" class="d-flex">
              <v-icon class="mt-half" color="primary" size="small"
                >mdi-clock
              </v-icon>
              <span class="ml-3"
                >{{ formatTimeFromTime(event?.start_time) }} -
                {{ formatTimeFromTime(event?.end_time) }}</span
              >
            </div>
            <div v-if="event?.location" class="d-flex">
              <v-icon class="mt-half" color="primary" size="small"
                >mdi-map-marker
              </v-icon>
              <span class="ml-3">{{ event?.location }}</span>
            </div>
            <div v-if="event?.category" class="d-flex">
              <v-icon class="mt-half" color="primary" size="small"
                >mdi-list-box
              </v-icon>
              <span class="ml-3">{{ event?.category }}</span>
            </div>
          </div>
          <v-btn
            :icon="event.isFavorite ? 'mdi-heart' : 'mdi-heart-outline'"
            color="primary"
            variant="text"
            @click="handleFavoriteEvent(event.isFavorite)"
          ></v-btn>
        </div>

        <p v-if="event?.description" class="mt-6 text-pre-wrap">
          {{ event?.description }}
        </p>

        <v-row v-if="event?.images?.length > 1" class="mt-6" justify="start">
          <v-col
            v-for="(image, index) in event?.images?.slice(1)"
            :key="index"
            cols="6"
          >
            <!--              loop started from second item-->
            <lightbox
              :key="image"
              :aspect-ratio="1.45"
              :img-set="event.images"
              :img-src="image"
              :opening-index="index + 1"
            ></lightbox>
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <!-- Comment Section -->
    <v-row class="mt-2 mt-md-4" justify="center">
      <v-col cols="12" md="8">
        <h3>Comments</h3>
        <v-divider />

        <!-- Comment Input -->
        <v-row :no-gutters="!!xs" align="center" class="mt-2 mt-md-4">
          <v-col v-if="!xs" class="mr-2 ml-md-0" cols="auto">
            <user-avatar
              :clickable="false"
              :imgSrc="currentUser.image"
            ></user-avatar>
          </v-col>
          <v-col class="mr-2 ml-md-0">
            <v-textarea
              v-model="newCommentText"
              auto-grow
              class="text-pre-wrap"
              density="compact"
              hide-details
              label="Write a comment..."
              required
              rows="1"
              variant="solo"
              @keyup.enter="addComment"
            ></v-textarea>
          </v-col>
          <v-col cols="auto">
            <v-btn
              :density="xs ? 'comfortable' : 'default'"
              color="primary"
              icon="mdi-send"
              @click="addComment"
            >
            </v-btn>
          </v-col>
        </v-row>

        <!-- Comments List -->
        <v-list v-if="event?.comments?.length > 0" class="mt-2 mt-md-4">
          <v-list-item
            v-for="(comment, index) in event?.comments"
            :key="index"
            class="mt-1 mt-md-3 px-0"
          >
            <v-row :no-gutters="!!mobile" align="center">
              <v-col class="mr-2 mr-md-0" cols="auto">
                <user-avatar
                  :imgSrc="comment?.image"
                  @click-avatar="goUserProfile(comment.user_id)"
                ></user-avatar>
              </v-col>
              <v-col>
                <v-sheet :elevation="5" class="pa-3" color="grey-lighten-3">
                  <v-hover v-slot="{ isHovering, props }">
                    <div class="position-relative" v-bind="props">
                      <v-btn
                        v-if="
                          isHovering && (isAdmin || isOwner(comment.user_id))
                        "
                        color="error"
                        icon="mdi-delete"
                        location="top end"
                        position="absolute"
                        rounded
                        size="x-small"
                        variant="flat"
                        @click="deleteComment(comment.id)"
                      ></v-btn>
                      <div class="d-flex align-center">
                        <v-list-item-title
                          class="clickable font-weight-bold"
                          @click="goUserProfile(comment.user_id)"
                          >{{ comment.full_name }}
                        </v-list-item-title>
                        <v-list-item-subtitle class="ml-2"
                          >{{ formatDateFromTimestamp(comment.created_at) }}
                        </v-list-item-subtitle>
                      </div>
                      <p class="text-pre-wrap">{{ comment.text }}</p>
                    </div>
                  </v-hover>
                </v-sheet>
              </v-col>
            </v-row>
          </v-list-item>
        </v-list>
      </v-col>
    </v-row>
  </v-container>
</template>
<style></style>
