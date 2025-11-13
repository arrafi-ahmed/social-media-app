<script setup>
  import { computed, onMounted, reactive, ref } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay, useTheme } from 'vuetify'
  import { useStore } from 'vuex'
  import ConfirmationDialog from '@/components/ConfirmationDialog.vue'
  import ImageManager from '@/components/ImageManager.vue'
  import PageTitle from '@/components/PageTitle.vue'
  import { User, UserSettings } from '@/models'
  import {
    formatDateFromTimestamp,
    formatPrice,
    getUserImageUrl,
    isValidEmail,
    isValidImage,
    isValidSlug,
  } from '@/others/util.js'

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
  const settings = computed(() => store.state.user.settings)
  const currentUser = computed(() => store.getters['auth/getCurrentUser'])
  const subscription = computed(() => store.state.subscription.subscription)
  const subscriptionPlans = computed(() => store.state.subscription.subscriptionPlans)
  const isSubscriptionActive = computed(() => store.getters['subscription/isSubscriptionActive'])
  const pendingCancel = computed(() => store.getters['subscription/pendingCancel'])

  // Check if current subscription is basic plan (no expiration)
  const isBasicPlan = computed(() => {
    if (!subscription.value?.planId) return false
    const plan = subscriptionPlans.value.find(p => p.id === subscription.value.planId)
    return plan?.title?.toLowerCase() === 'basic' || subscription.value?.stripeSubscriptionId === 0 || subscription.value?.stripeSubscriptionId === '0'
  })

  // User model for profile updates
  const userInit = new User()
  const newUser = reactive({ ...userInit })
  newUser.newPassword = null
  newUser.confirmPassword = null
  newUser.newProfilePicture = null
  const imageDeleted = ref(false)

  // UserSettings model for notification settings
  const settingsInit = new UserSettings()
  const newSettings = reactive({ ...settingsInit })

  function handleProfileImageChange (files) {
    // When new image is uploaded, reset deletion flag
    if (files) {
      imageDeleted.value = false
    }
  }

  function handleDeleteProfileImage () {
    // When ImageManager delete is clicked, mark image for deletion
    imageDeleted.value = true
    newUser.newProfilePicture = null
  }

  const expansionPanel = ref([0])
  const form = ref(null)
  const isFormValid = ref(true)

  async function updateProfile () {
    const validationResult = await form.value?.validate()
    if (validationResult?.valid === false || !isFormValid.value) return

    // Validate password match if password is provided
    if (newUser.newPassword && newUser.newPassword !== newUser.confirmPassword) {
      return
    }

    const formData = new FormData()
    formData.append('fullName', newUser.fullName)
    formData.append('email', newUser.email)
    if (newUser.newPassword) {
      formData.append('password', newUser.newPassword)
    }
    if (newUser.slug) {
      formData.append('slug', newUser.slug)
    }

    if (newUser.newProfilePicture) {
      // v-file-upload may return array or single file - handle both cases
      const fileToUpload = Array.isArray(newUser.newProfilePicture)
        ? newUser.newProfilePicture[0]
        : newUser.newProfilePicture
      if (fileToUpload) {
        formData.append('files', fileToUpload)
        if (profile.value?.image) formData.append('rmImage', profile.value?.image)
      }
    } else if (imageDeleted.value && profile.value?.image) {
      // If image was deleted via ImageManager, add rmImage without new file
      formData.append('rmImage', profile.value?.image)
    }

    try {
      await store.dispatch('user/updateProfile', formData)
      // Reset form after successful update
      imageDeleted.value = false
      newUser.newProfilePicture = null
      newUser.newPassword = null
      newUser.confirmPassword = null
    } catch (error) {
      console.error('Failed to update profile:', error)
    }
  }

  function handleEmailNewEventNotification (value) {
    settings.value.emailNewEventNotification = value
    store.dispatch('user/updateEmailNewEventNotification', value)
  }

  function handleEmailNewCommentNotification (value) {
    settings.value.emailNewCommentNotification = value
    store.dispatch('user/updateEmailNewCommentNotification', value)
  }

  function handleEmailUpdateEventNotification (value) {
    settings.value.emailUpdateEventNotification = value
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

  onMounted(async () => {
    await store.dispatch('user/setProfileWSettings')
    // Map profile data to user model
    Object.assign(newUser, { ...profile.value })
    // Reset image deletion flag when profile loads
    imageDeleted.value = false
    newUser.newProfilePicture = null

    Object.assign(newSettings, { ...settings.value })

    // Fetch subscription data
    if (currentUser.value?.id) {
      await Promise.all([
        store.dispatch('subscription/setSubscription', currentUser.value.id),
        store.dispatch('subscription/setSubscriptionPlans'),
      ])
    }
  })
</script>
<template>
  <v-container>
    <page-title :back-url="calcHome" subtitle="Manage your account" title="Settings" />

    <div class="page-content">
      <v-expansion-panels v-model="expansionPanel" variant="inset">
        <!-- Update Profile Section -->
        <v-expansion-panel>
          <v-expansion-panel-title>
            <div class="d-flex align-center justify-space-between w-100 pr-4">
              <div>
                <div class="text-h6 font-weight-bold">Update Profile</div>
                <div class="text-caption text-medium-emphasis">
                  Manage your personal information
                </div>
              </div>
              <v-icon icon="mdi-account-edit" />
            </div>
          </v-expansion-panel-title>
          <v-expansion-panel-text>
            <v-form
              ref="form"
              v-model="isFormValid"
              class="mt-3"
              fast-fail
              @submit.prevent="updateProfile"
            >
              <v-text-field
                v-model="newUser.fullName"
                class="mt-3"
                clearable
                density="compact"
                hide-details="auto"
                label="Full Name"
                :rules="[(v) => !!v || 'Full Name is required!']"
                variant="solo"
              />
              <v-text-field
                v-model="newUser.email"
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
                v-model="newUser.slug"
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
                v-model="newUser.newPassword"
                class="mt-3"
                clearable
                density="compact"
                hide-details="auto"
                label="New Password"
                type="password"
                variant="solo"
              />
              <v-text-field
                v-model="newUser.confirmPassword"
                class="mt-3"
                clearable
                density="compact"
                hide-details="auto"
                label="Confirm Password"
                :rules="[
                  (v) => !newUser.newPassword || !!v || 'Please confirm your password',
                  (v) => !newUser.newPassword || v === newUser.newPassword || 'Passwords do not match',
                ]"
                type="password"
                variant="solo"
              />
              <div class="mt-3">
                <image-manager
                  v-if="profile?.image && !imageDeleted"
                  container-class="mb-3"
                  max-height="200px"
                  max-width="200px"
                  :src="getUserImageUrl(profile?.image)"
                  @delete="handleDeleteProfileImage"
                />
                <v-file-upload
                  v-model="newUser.newProfilePicture"
                  accept="image/*"
                  clearable
                  density="compact"
                  :hide-browse="false"
                  :rules="[
                    (v) =>
                      !v ||
                      (Array.isArray(v) ? v : [v]).every((file) =>
                        isValidImage(file),
                      ) || 'Only jpeg/png allowed!',
                  ]"
                  show-size
                  title="Upload Profile Picture"
                  variant=""
                  @update:model-value="handleProfileImageChange"
                />
                <div v-if="imageDeleted && !newUser.newProfilePicture" class="text-body-2 text-medium-emphasis mt-2">
                  Profile picture removed. Upload a new one or save to confirm deletion.
                </div>
              </div>
              <v-card-actions class="pa-0 mt-5">
                <v-spacer />
                <v-btn
                  color="primary"
                  :density="mobile ? 'comfortable' : 'default'"
                  prepend-icon="mdi-content-save"
                  type="submit"
                  variant="flat"
                >Save
                </v-btn>
              </v-card-actions>
            </v-form>
          </v-expansion-panel-text>
        </v-expansion-panel>

        <!-- Subscription Section -->
        <v-expansion-panel>
          <v-expansion-panel-title>
            <div class="d-flex align-center justify-space-between w-100 pr-4">
              <div>
                <div class="text-h6 font-weight-bold">Subscription</div>
                <div class="text-caption text-medium-emphasis">
                  Manage your subscription plan
                </div>
              </div>
              <v-icon icon="mdi-credit-card" />
            </div>
          </v-expansion-panel-title>
          <v-expansion-panel-text>
            <div v-if="isSubscriptionActive && subscription?.planId" class="mt-3">
              <div class="d-flex align-center justify-space-between mb-3">
                <div>
                  <div class="text-h6 font-weight-bold">
                    {{ subscriptionPlans.find(p => p.id === subscription.planId)?.title || "Active Plan" }}
                  </div>
                  <div v-if="isBasicPlan" class="text-body-2 text-medium-emphasis mt-1">
                    No expiration
                  </div>
                  <div v-else-if="subscription.expireDate" class="text-body-2 text-medium-emphasis mt-1">
                    Expires: {{ formatDateFromTimestamp(subscription.expireDate) }}
                  </div>
                  <div v-if="pendingCancel" class="text-body-2 text-error mt-1">
                    Subscription will be cancelled
                  </div>
                </div>
                <v-chip
                  :color="pendingCancel ? 'warning' : 'success'"
                  size="small"
                  variant="flat"
                >
                  {{ pendingCancel ? "Cancelling" : "Active" }}
                </v-chip>
              </div>
              <div v-if="subscriptionPlans.find(p => p.id === subscription.planId)" class="text-body-1 mb-3">
                <strong>{{
                  formatPrice(subscriptionPlans.find(p => p.id === subscription.planId).price, subscriptionPlans.find(p => p.id === subscription.planId).currency)
                }}</strong>
              </div>
            </div>
            <div v-else class="mt-3 text-body-1 text-medium-emphasis">
              No active subscription
            </div>
            <v-row align="center" class="mt-3" justify="end" no-gutters>
              <v-col cols="auto">
                <v-btn
                  class="ml-auto"
                  color="primary"
                  :density="mobile ? 'comfortable' : 'default'"
                  prepend-icon="mdi-lock-open-check"
                  :to="{ name: 'pricing' }"
                >{{ isSubscriptionActive ? "Update Plan" : "Choose Plan" }}
                </v-btn>
              </v-col>
            </v-row>
          </v-expansion-panel-text>
        </v-expansion-panel>

        <!-- Appearance Section -->
        <v-expansion-panel>
          <v-expansion-panel-title>
            <div class="d-flex align-center justify-space-between w-100 pr-4">
              <div>
                <div class="text-h6 font-weight-bold">Appearance</div>
                <div class="text-caption text-medium-emphasis">
                  Customize your theme preferences
                </div>
              </div>
              <v-icon icon="mdi-palette" />
            </div>
          </v-expansion-panel-title>
          <v-expansion-panel-text>
            <v-switch
              v-model="settings.theme"
              class="mt-3"
              color="primary"
              false-value="light"
              hide-details
              inset
              label="Dark mode"
              true-value="dark"
              @update:model-value="handleThemeToggle(settings.theme)"
            />
          </v-expansion-panel-text>
        </v-expansion-panel>

        <!-- Email Notification Section -->
        <v-expansion-panel>
          <v-expansion-panel-title>
            <div class="d-flex align-center justify-space-between w-100 pr-4">
              <div>
                <div class="text-h6 font-weight-bold">Email Notification</div>
                <div class="text-caption text-medium-emphasis">
                  Configure your email preferences
                </div>
              </div>
              <v-icon icon="mdi-email" />
            </div>
          </v-expansion-panel-title>
          <v-expansion-panel-text>
            <v-switch
              v-model="newSettings.emailNewEventNotification"
              class="mt-3"
              color="primary"
              hide-details
              inset
              label="When friends post new event"
              @update:model-value="
                handleEmailNewEventNotification(newSettings.emailNewEventNotification)
              "
            />
            <v-switch
              v-model="newSettings.emailUpdateEventNotification"
              class="mt-3"
              color="primary"
              hide-details
              inset
              label="When friends edit event"
              @update:model-value="
                handleEmailUpdateEventNotification(
                  newSettings.emailUpdateEventNotification,
                )
              "
            />
            <v-switch
              v-model="newSettings.emailNewCommentNotification"
              class="mt-3"
              color="primary"
              hide-details
              inset
              label="When friends comment on your event"
              @update:model-value="
                handleEmailNewCommentNotification(
                  newSettings.emailNewCommentNotification,
                )
              "
            />
          </v-expansion-panel-text>
        </v-expansion-panel>

        <!-- Account Delete Section -->
        <v-expansion-panel>
          <v-expansion-panel-title>
            <div class="d-flex align-center justify-space-between w-100 pr-4">
              <div>
                <div class="text-h6 font-weight-bold">Account Delete</div>
                <div class="text-caption text-medium-emphasis">
                  Permanently delete your account
                </div>
              </div>
              <v-icon icon="mdi-account-remove" />
            </div>
          </v-expansion-panel-title>
          <v-expansion-panel-text>
            <div class="mt-3">Do you want to delete your account?</div>

            <v-row justify="end">
              <v-col cols="auto">
                <confirmation-dialog
                  popup-content="Please cancel any existing subscription before you delete your account."
                  popup-title="Delete"
                  @confirm="deleteAccount"
                >
                  <template #activator="{ onClick }">
                    <v-btn
                      class="ms-auto mt-3"
                      color="error"
                      prepend-icon="mdi-trash-can-outline"
                      variant="flat"
                      @click="onClick"
                    >Delete
                    </v-btn>
                  </template>
                </confirmation-dialog>
              </v-col>
            </v-row>
          </v-expansion-panel-text>
        </v-expansion-panel>
      </v-expansion-panels>
    </div>
  </v-container>
</template>

<style></style>
