<script setup>
import { computed, onMounted, ref } from "vue";
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import { isValidEmail, isValidImage } from "@/util";
import PageTitle from "@/components/PageTitle.vue";
import { useDisplay } from "vuetify";
import RemoveEntity from "@/components/RemoveEntity.vue";
import UserAvatar from "@/components/UserAvatar.vue";

const { mobile } = useDisplay();
const router = useRouter();
const store = useStore();

const profile = computed(() => store.state.cuser.profile);

const fullname = ref(profile.value?.full_name);
const newEmail = ref(profile.value?.email);
const newPassword = ref(null);
const newProfilePicture = ref(null);

const handleProfileImageChange = (files) => {
  newProfilePicture.value = files;
};

const form = ref(null);
const isFormValid = ref(true);

const updateProfile = async () => {
  await form.value.validate();
  if (!isFormValid.value) return;

  const formData = new FormData();
  formData.append("full_name", fullname.value);
  formData.append("email", newEmail.value);
  if (newPassword.value) {
    formData.append("password", newPassword.value);
  }

  if (newProfilePicture.value) {
    formData.append("files", newProfilePicture.value);
    if (profile.value?.image) formData.append("rmImage", profile.value?.image);
  }
  store.dispatch("cuser/updateProfile", formData);
};

const emailNewEventNotification = ref(null);
const emailNewCommentNotification = ref(null);
const emailUpdateEventNotification = ref(null);

const handleEmailNewEventNotification = (value) => {
  store.dispatch("cuser/updateEmailNewEventNotification", value);
};

const handleEmailNewCommentNotification = (value) => {
  store.dispatch("cuser/updateEmailNewCommentNotification", value);
};

const handleEmailUpdateEventNotification = (value) => {
  store.dispatch("cuser/updateEmailUpdateEventNotification", value);
};

const deleteAccount = () => {
  store
    .dispatch("cuser/deleteAccount", { rmImage: profile.value?.image })
    .then(() => {
      router.push({ name: "signout" });
    });
};

onMounted(() => {
  store.dispatch("cuser/setProfileWSettings").then(() => {
    fullname.value = profile.value?.full_name;
    newEmail.value = profile.value?.email;
    emailNewEventNotification.value =
      profile.value?.email_new_event_notification;
    emailUpdateEventNotification.value =
      profile.value?.email_update_event_notification;
    emailNewCommentNotification.value =
      profile.value?.email_new_comment_notification;
  });
});
</script>
<template>
  <v-container>
    <page-title title="Settings"></page-title>

    <v-row justify="center">
      <v-col cols="12" md="5">
        <h3 class="mt-5">Update profile</h3>
        <v-divider></v-divider>

        <v-form
          ref="form"
          v-model="isFormValid"
          class="mt-5"
          fast-fail
          @submit.prevent="updateProfile"
        >
          <v-text-field
            v-model="fullname"
            :rules="[(v) => !!v || 'Full Name is required!']"
            class="mt-3"
            clearable
            density="compact"
            hide-details="auto"
            label="Full Name"
            variant="solo"
          ></v-text-field>
          <v-text-field
            v-model="newEmail"
            :rules="[
              (v) => !!v || 'Email is required!',
              (v) => isValidEmail(v) || 'Invalid Email',
            ]"
            class="mt-3"
            clearable
            density="compact"
            hide-details="auto"
            label="Email Address"
            variant="solo"
          ></v-text-field>
          <v-text-field
            v-model="newPassword"
            class="mt-3"
            clearable
            density="compact"
            hide-details="auto"
            label="New Password"
            type="password"
            variant="solo"
          ></v-text-field>
          <div class="d-flex align-center mt-3">
            <user-avatar
              :clickable="false"
              :imgSrc="profile?.image"
            ></user-avatar>
            <v-file-input
              :rules="[
                (v) =>
                  (Array.isArray(v) ? v : [v]).every((file) =>
                    isValidImage(file)
                  ) || 'Only jpg/jpeg/png allowed!',
              ]"
              accept="image/*"
              class="ml-2"
              density="compact"
              hide-details="auto"
              label="Profile picture"
              prepend-icon=""
              prepend-inner-icon="mdi-camera"
              show-size
              variant="solo"
              @update:modelValue="handleProfileImageChange"
            >
              <template v-slot:selection="{ fileNames }">
                <template v-for="fileName in fileNames" :key="fileName">
                  <v-chip class="me-2" color="primary" label size="small">
                    {{ fileName }}
                  </v-chip>
                </template>
              </template>
            </v-file-input>
          </div>

          <v-btn
            :density="mobile ? 'comfortable' : 'default'"
            class="ml-auto mt-5 d-block"
            color="primary"
            type="submit"
            >Update Profile
          </v-btn>
        </v-form>
      </v-col>
    </v-row>

    <v-row align="center" class="mt-2 mt-md-5" justify="center">
      <v-col cols="12" md="5">
        <h3 class="mt-5">Subscription</h3>
        <v-divider></v-divider>
        <v-row align="center" class="mt-2" justify="end" no-gutters>
          <v-col cols="auto">
            <v-btn
              :density="mobile ? 'comfortable' : 'default'"
              :to="{ name: 'pricing' }"
              class="ml-auto mt-5"
              color="primary"
              >Update Plan
            </v-btn>
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-row justify="center">
      <v-col cols="12" md="5">
        <h3 class="mt-5">Email Notification</h3>
        <v-divider></v-divider>

        <v-switch
          v-model="emailNewEventNotification"
          :false-value="0"
          :true-value="1"
          color="primary"
          hide-details
          inset
          label="When friends post new event"
          @update:modelValue="
            handleEmailNewEventNotification(emailNewEventNotification)
          "
        ></v-switch>
        <v-switch
          v-model="emailUpdateEventNotification"
          :false-value="0"
          :true-value="1"
          color="primary"
          hide-details
          inset
          label="When friends edit event"
          @update:modelValue="
            handleEmailUpdateEventNotification(emailUpdateEventNotification)
          "
        ></v-switch>
        <v-switch
          v-model="emailNewCommentNotification"
          :false-value="0"
          :true-value="1"
          color="primary"
          hide-details
          inset
          label="When friends comment on your event"
          @update:modelValue="
            handleEmailNewCommentNotification(emailNewCommentNotification)
          "
        ></v-switch>
      </v-col>
    </v-row>

    <v-row align="center" class="mt-2 mt-md-5" justify="center">
      <v-col cols="12" md="5">
        <h3 class="mt-5">Account Delete</h3>
        <v-divider></v-divider>
        <div class="mt-5">
          <div>Do you want to delete your account?</div>

          <v-row justify="end">
            <v-col cols="auto">
              <remove-entity
                btn-variant="flat"
                custom-class="ms-auto"
                message="Please cancel any existing subscription before you delete your account."
                size="default"
                text="Delete"
                @remove-entity="deleteAccount"
              ></remove-entity>
            </v-col>
          </v-row>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<style></style>
