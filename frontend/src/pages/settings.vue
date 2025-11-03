<script setup>
  import { computed, onMounted, reactive, ref, watch } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay, useTheme } from 'vuetify'
  import { useStore } from 'vuex'
  import ConfirmationDialog from '@/components/ConfirmationDialog.vue'
  import PageTitle from '@/components/PageTitle.vue'
  import UserAvatar from '@/components/UserAvatar.vue'
  import { User, UserSettings } from '@/models'
  import { isValidEmail, isValidImage, isValidSlug } from '@/others/util.js'

  definePage({
    name: 'settings',
    meta: {
      requiresAuth: true,
      title: 'Settings',
      layout: 'default',
    },
  })

  const { mobile } = useDisplay()
  const theme = useTheme()
  const router = useRouter()
  const store = useStore()

  const calcHome = computed(() => store.getters['auth/calcHome'])
  const profile = computed(() => store.state.user.profile)

  // User model for profile updates
  const userInit = new User()
  const user = reactive({ ...userInit })
  user.newPassword = null
  user.newProfilePicture = null
  user.slug = null

  // UserSettings model for notification settings
  const settingsInit = new UserSettings()
  const settings = reactive({ ...settingsInit })

  function handleProfileImageChange (files) {
    user.newProfilePicture = files
  }

  const form = ref(null)
  const isFormValid = ref(true)

  async function updateProfile () {
    await form.value.validate()
    if (!isFormValid.value) return

    const formData = new FormData()
    formData.append('fullName', user.fullName)
    formData.append('email', user.email)
    if (user.newPassword) {
      formData.append('password', user.newPassword)
    }
    if (user.slug) {
      formData.append('slug', user.slug)
    }

    if (user.newProfilePicture) {
      formData.append('files', user.newProfilePicture)
      if (profile.value?.image) formData.append('rmImage', profile.value?.image)
    }

    store.dispatch('user/updateProfile', formData).then(() => {
      // Reset form after successful update
    })
  }

  function handleEmailNewEventNotification (value) {
    settings.emailNewEventNotification = value
    store.dispatch('user/updateEmailNewEventNotification', value)
  }

  function handleEmailNewCommentNotification (value) {
    settings.emailNewCommentNotification = value
    store.dispatch('user/updateEmailNewCommentNotification', value)
  }

  function handleEmailUpdateEventNotification (value) {
    settings.emailUpdateEventNotification = value
    store.dispatch('user/updateEmailUpdateEventNotification', value)
  }

  function handleThemeToggle (value) {
    // Immediately update Vuetify theme
    theme.global.name.value = value
    store.dispatch('user/updateSettings', { theme: value })
  }

  function deleteAccount () {
    store
      .dispatch('user/deleteAccount', { rmImage: profile.value?.image })
      .then(() => {
        router.push({ name: 'signout' })
      })
  }

  onMounted(() => {
    store.dispatch('user/setProfileWSettings').then(() => {
      // Map profile data to user model
      Object.assign(user, {
        id: profile.value?.id,
        fullName: profile.value?.fullName,
        email: profile.value?.email,
        image: profile.value?.image,
        slug: profile.value?.slug,
        role: profile.value?.role,
        createdAt: profile.value?.createdAt,
      })

      // Map settings data to settings model
      Object.assign(settings, {
        id: profile.value?.settings?.id,
        emailNewEventNotification: profile.value?.emailNewEventNotification,
        emailUpdateEventNotification: profile.value?.emailUpdateEventNotification,
        emailNewCommentNotification: profile.value?.emailNewCommentNotification,
        sort: profile.value?.settings?.sort,
        theme: profile.value?.theme || 'light',
        userId: profile.value?.id,
      })
    })
  })
</script>
<template>
  <v-container>
    <page-title :back-url="calcHome" subtitle="Manage your account" title="Settings" />

    <v-row justify="center">
      <v-col cols="12" md="5">
        <h3 class="mt-5">Update profile</h3>
        <v-divider />

        <v-form
          ref="form"
          v-model="isFormValid"
          class="mt-5"
          fast-fail
          @submit.prevent="updateProfile"
        >
          <v-text-field
            v-model="user.fullName"
            class="mt-3"
            clearable
            density="compact"
            hide-details="auto"
            label="Full Name"
            :rules="[(v) => !!v || 'Full Name is required!']"
            variant="solo"
          />
          <v-text-field
            v-model="user.email"
            class="mt-3"
            clearable
            density="compact"
            hide-details="auto"
            label="Email Address"
            :rules="[
              (v) => !!v || 'Email is required!',
              (v) => isValidEmail(v) || 'Invalid Email',
            ]"
            variant="solo"
          />
          <v-text-field
            v-model="user.slug"
            class="mt-3"
            clearable
            density="compact"
            hide-details="auto"
            hint="Your custom URL identifier (e.g., yourprofile)"
            label="Profile Slug"
            persistent-hint
            :rules="[
              (v) => !v || isValidSlug(v) || 'Slug must be 3-50 chars, lowercase letters, numbers, and hyphens only',
            ]"
            variant="solo"
          />
          <v-text-field
            v-model="user.newPassword"
            class="mt-3"
            clearable
            density="compact"
            hide-details="auto"
            label="New Password"
            type="password"
            variant="solo"
          />
          <div class="d-flex align-center mt-3">
            <user-avatar :clickable="false" :img-src="profile?.image" />
            <v-file-input
              accept="image/*"
              class="ml-2"
              density="compact"
              hide-details="auto"
              label="Profile picture"
              prepend-icon=""
              prepend-inner-icon="mdi-camera"
              show-size
              variant="solo"
              @update:model-value="handleProfileImageChange"
            >
              <template #selection="{ fileNames }">
                <template v-for="fileName in fileNames" :key="fileName">
                  <v-chip class="me-2" color="primary" label size="small">
                    {{ fileName }}
                  </v-chip>
                </template>
              </template>
            </v-file-input>
          </div>

          <v-btn
            class="ml-auto mt-5 d-block"
            color="primary"
            :density="mobile ? 'comfortable' : 'default'"
            type="submit"
          >Update Profile
          </v-btn>
        </v-form>
      </v-col>
    </v-row>

    <v-row align="center" class="mt-2 mt-md-5" justify="center">
      <v-col cols="12" md="5">
        <h3 class="mt-5">Subscription</h3>
        <v-divider />
        <v-row align="center" class="mt-2" justify="end" no-gutters>
          <v-col cols="auto">
            <v-btn
              class="ml-auto mt-5"
              color="primary"
              :density="mobile ? 'comfortable' : 'default'"
              :to="{ name: 'pricing' }"
            >Update Plan
            </v-btn>
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-row justify="center">
      <v-col cols="12" md="5">
        <h3 class="mt-5">Appearance</h3>
        <v-divider />

        <v-switch
          v-model="settings.theme"
          color="primary"
          false-value="light"
          hide-details
          inset
          label="Dark mode"
          true-value="dark"
          @update:model-value="handleThemeToggle(settings.theme)"
        />
      </v-col>
    </v-row>

    <v-row justify="center">
      <v-col cols="12" md="5">
        <h3 class="mt-5">Email Notification</h3>
        <v-divider />

        <v-switch
          v-model="settings.emailNewEventNotification"
          color="primary"
          :false-value="0"
          hide-details
          inset
          label="When friends post new event"
          :true-value="1"
          @update:model-value="
            handleEmailNewEventNotification(settings.emailNewEventNotification)
          "
        />
        <v-switch
          v-model="settings.emailUpdateEventNotification"
          color="primary"
          :false-value="0"
          hide-details
          inset
          label="When friends edit event"
          :true-value="1"
          @update:model-value="
            handleEmailUpdateEventNotification(
              settings.emailUpdateEventNotification,
            )
          "
        />
        <v-switch
          v-model="settings.emailNewCommentNotification"
          color="primary"
          :false-value="0"
          hide-details
          inset
          label="When friends comment on your event"
          :true-value="1"
          @update:model-value="
            handleEmailNewCommentNotification(
              settings.emailNewCommentNotification,
            )
          "
        />
      </v-col>
    </v-row>

    <v-row align="center" class="mt-2 mt-md-5" justify="center">
      <v-col cols="12" md="5">
        <h3 class="mt-5">Account Delete</h3>
        <v-divider />
        <div class="mt-5">
          <div>Do you want to delete your account?</div>

          <v-row justify="end">
            <v-col cols="auto">
              <confirmation-dialog
                popup-content="Please cancel any existing subscription before you delete your account."
                popup-title="Delete"
                @confirm="deleteAccount"
              >
                <template #activator="{ onClick }">
                  <v-btn
                    class="ms-auto"
                    color="error"
                    variant="flat"
                    @click="onClick"
                  >Delete</v-btn>
                </template>
              </confirmation-dialog>
            </v-col>
          </v-row>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<style></style>
