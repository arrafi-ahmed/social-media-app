<script setup>
  import { computed, onMounted, reactive, ref, watch } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay, useTheme } from 'vuetify'
  import { useStore } from 'vuex'
  import ConfirmationDialog from '@/components/ConfirmationDialog.vue'
  import ImageManager from '@/components/ImageManager.vue'
  import PageTitle from '@/components/PageTitle.vue'
  import { User, UserSettings } from '@/models'
  import { formatDateFromTimestamp, formatPrice, getUserImageUrl, isValidEmail, isValidImage, isValidSlug } from '@/others/util.js'

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
  const user = reactive({ ...userInit })
  user.newPassword = null
  user.newProfilePicture = null
  user.slug = null
  const imageDeleted = ref(false)

  // UserSettings model for notification settings
  const settingsInit = new UserSettings()
  const settings = reactive({ ...settingsInit })

  function handleProfileImageChange (files) {
    // When new image is uploaded, reset deletion flag
    if (files) {
      imageDeleted.value = false
    }
  }

  function handleDeleteProfileImage () {
    // When ImageManager delete is clicked, mark image for deletion
    imageDeleted.value = true
    user.newProfilePicture = null
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
      // v-file-upload may return array or single file - handle both cases
      const fileToUpload = Array.isArray(user.newProfilePicture)
        ? user.newProfilePicture[0]
        : user.newProfilePicture
      if (fileToUpload) {
        formData.append('files', fileToUpload)
        if (profile.value?.image) formData.append('rmImage', profile.value?.image)
      }
    } else if (imageDeleted.value && profile.value?.image) {
      // If image was deleted via ImageManager, add rmImage without new file
      formData.append('rmImage', profile.value?.image)
    }

    store.dispatch('user/updateProfile', formData).then(() => {
      // Reset form after successful update
      imageDeleted.value = false
      user.newProfilePicture = null
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

  onMounted(async () => {
    await store.dispatch('user/setProfileWSettings')
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
    // Reset image deletion flag when profile loads
    imageDeleted.value = false
    user.newProfilePicture = null

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
      <v-expansion-panels variant="accordion">
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
                  v-model="user.newProfilePicture"
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
                <div v-if="imageDeleted && !user.newProfilePicture" class="text-body-2 text-medium-emphasis mt-2">
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
                    {{ subscriptionPlans.find(p => p.id === subscription.planId)?.title || 'Active Plan' }}
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
                  {{ pendingCancel ? 'Cancelling' : 'Active' }}
                </v-chip>
              </div>
              <div v-if="subscriptionPlans.find(p => p.id === subscription.planId)" class="text-body-1 mb-3">
                <strong>{{ formatPrice(subscriptionPlans.find(p => p.id === subscription.planId).price, subscriptionPlans.find(p => p.id === subscription.planId).currency) }}</strong>
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
                >{{ isSubscriptionActive ? 'Update Plan' : 'Choose Plan' }}
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
              v-model="settings.emailNewEventNotification"
              class="mt-3"
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
              class="mt-3"
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
              class="mt-3"
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
                    >Delete</v-btn>
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
