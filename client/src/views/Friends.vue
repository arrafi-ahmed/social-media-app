<script setup>
import NameCard from "@/components/NameCard.vue";
import { computed, onMounted, ref } from "vue";
import { useStore } from "vuex";
import PageTitle from "@/components/PageTitle.vue";
import { useDisplay } from "vuetify";
import RemoveEntity from "@/components/RemoveEntity.vue";

const { mobile } = useDisplay();
const store = useStore();

const friends = computed(() => store.state.cuser.friends);
const currentUser = computed(() => store.getters["cuser/getCurrentUser"]);

const form = ref(null);
const isFormValid = ref(true);

const dialog = ref(false);
const email = ref(null);
const message = ref(null);

const sendInvite = async () => {
  await form.value.validate();
  if (!isFormValid.value) return;

  const invitation = {
    email: email.value,
    message: message.value,
  };

  store.dispatch("cuser/sendInvite", invitation).then((result) => {
    email.value = null;
    message.value = null;
    dialog.value = false;
  });
};

const removeFriend = (friendship_id) => {
  store.dispatch("cuser/removeFriend", friendship_id);
};
onMounted(() => {
  store.dispatch("cuser/setFriends");
});
</script>

<template>
  <v-container>
    <v-row justify="center">
      <!-- Main content -->
      <v-col cols="12">
        <page-title :title="`Friends (${friends.length})`">
          <v-btn
            :density="mobile ? 'comfortable' : 'default'"
            variant="flat"
            @click="$router.push({ name: 'friends-invite' })"
          >
            <template v-slot:prepend>
              <v-icon color="primary">mdi-plus</v-icon>
            </template>
            Invite a friend
          </v-btn>
        </page-title>

        <v-row justify="center">
          <v-col cols="12" md="7">
            <v-list>
              <v-list-item
                v-for="(item, index) in friends"
                :key="index"
                :class="{ 'px-1': mobile }"
                link
              >
                <div
                  class="d-flex justify-space-between align-center"
                  @click="
                    $router.push({ name: 'wall', params: { id: item.id } })
                  "
                >
                  <name-card
                    :profile="item"
                    container-class="clickable"
                    img-class="rounded-circle"
                  ></name-card>
                  <remove-entity
                    :id="item.friendship_id"
                    :key="item.friendship_id"
                    size="small"
                    @remove-entity="removeFriend"
                  ></remove-entity>
                </div>
              </v-list-item>
            </v-list>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
