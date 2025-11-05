<script setup>
  import { computed, nextTick, onMounted, reactive, ref, watch } from 'vue'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import ConfirmationDialog from '@/components/ConfirmationDialog.vue'
  import NameCard from '@/components/NameCard.vue'
  import NoItems from '@/components/NoItems.vue'
  import PageTitle from '@/components/PageTitle.vue'
  import RichTextEditor from '@/components/RichTextEditor.vue'
  import { formatDateFromTimestamp, getBlogImageUrl, getPageImageUrl, isValidImage } from '@/others/util.js'
  import $axios from '@/plugins/axios.js'

  definePage({
    name: 'adminDashboard',
    meta: {
      requiresAuth: true,
      requiresAdmin: true,
      layout: 'default',
      title: 'Admin Dashboard',
    },
  })

  const { xs } = useDisplay()
  const store = useStore()
  const tab = ref('site')

  const blogs = computed(() => store.state.blog.blogs)
  const categories = computed(() => store.state.category.categories)
  const foundUsers = computed(() => store.state.user.foundUsers)

  const initLanding = computed(() => store.state.page.landing)
  const initAbout = computed(() => store.state.page.about)
  const initPrivacy = computed(() => store.state.page.privacy)
  const initTerms = computed(() => store.state.page.terms)

  const newCategoryDialog = ref(false)
  const editCategoryDialog = ref(false)
  const newBlogDialog = ref(false)
  const editBlogDialog = ref(false)

  const searchingUser = ref(null)
  const categorySearch = ref('')
  const blogSearch = ref('')

  const updatingAboutTitle = ref(null)
  const updatingAboutText = ref(null)
  const updatingTermsTitle = ref(null)
  const updatingTermsText = ref(null)
  const updatingPrivacyTitle = ref(null)
  const updatingPrivacyText = ref(null)

  const newCategoryTitle = ref(null)

  const addCategoryForm = ref(null)
  const isAddCategoryFormValid = ref(true)

  async function addCategory () {
    await addCategoryForm.value.validate()
    if (!isAddCategoryFormValid.value) return

    const newCategory = { name: newCategoryTitle.value }
    store.dispatch('category/addCategory', newCategory).then(() => {
      newCategoryDialog.value = false
    })
  }

  let editingCategory = reactive({ id: null, name: null })

  function openEditCategoryDialog (item) {
    Object.assign(editingCategory, item)
    editCategoryDialog.value = !editCategoryDialog.value
  }

  const editCategoryForm = ref(null)
  const isEditCategoryFormValid = ref(true)

  async function editCategory (item) {
    // await editCategoryForm?.value?.[index].validate();
    // if (!isEditCategoryFormValid.value) return;
    if (!item.name) {
      isEditCategoryFormValid.value = false
      return
    }
    store.dispatch('category/editCategory', item).then(() => {
      editCategoryDialog.value = false
      editingCategory = { id: null, name: null }
    })
  }

  const blogInit = {
    title: null,
    description: null,
    image: null,
  }
  const newBlog = reactive({ ...blogInit })

  function openNewBlogDialog () {
    Object.assign(newBlog, blogInit)
    newBlogDialog.value = !newBlogDialog.value
  }

  const addBlogForm = ref(null)
  const isAddBlogFormValid = ref(true)

  async function addBlog () {
    await addBlogForm.value.validate()
    if (!isAddBlogFormValid.value) return

    const formData = new FormData()
    formData.append('title', newBlog.title)
    formData.append('description', newBlog.description)
    formData.append('files', newBlog.image)
    store.dispatch('blog/addBlog', formData).then(() => {
      newBlogDialog.value = false
    })
  }

  const editingBlog = reactive({ ...blogInit, id: null })

  function openEditBlogDialog (item) {
    editBlogDialog.value = !editBlogDialog.value
    Object.assign(editingBlog, { ...item, newImage: null })
  }

  const editBlogForm = ref(null)
  const isEditBlogFormValid = ref(true)

  async function editBlog () {
    // await editBlogForm.value.validate();
    // if (!isEditBlogFormValid.value) return;

    if (!editingBlog.title || !editingBlog.description) {
      isEditBlogFormValid.value = false
      return
    }

    const formData = new FormData()
    formData.append('id', editingBlog.id)
    formData.append('title', editingBlog.title)
    formData.append('description', editingBlog.description)

    if (editingBlog.newImage) {
      formData.append('files', editingBlog.newImage)
      if (editingBlog.image) formData.append('rmImage', editingBlog.image)
    }
    store.dispatch('blog/editBlog', formData).then(() => {
      editBlogDialog.value = !editBlogDialog.value
    })
  }

  function deleteBlog (blogId, rmImage) {
    store.dispatch('blog/deleteBlog', { blogId, rmImage })
  }

  function deleteCategory (categoryId) {
    store.dispatch('category/deleteCategory', categoryId)
  }

  function searchUser () {
    store.dispatch('user/searchUser', searchingUser.value)
  }

  function deleteUser (id) {
    store.dispatch('user/deleteUser', id)
  }

  const updatingLanding = ref([
    { title: null, description: null, image: null },
    { title: null, description: null, image: null },
    { title: null, description: null, image: null },
    { title: null, description: null, image: null },
  ])

  async function handleUpdateLanding () {
    const formData = new FormData()
    formData.append('id', initLanding.value.id)
    formData.append('title', 'Landing')
    formData.append('pageName', 'landing')

    const updatingLandingImages = []
    for (let i = 0; i < updatingLanding.value.length; i++) {
      const item = updatingLanding.value[i]
      if (item.newImage instanceof File) {
        console.log(4, item.newImage.name)
        formData.append('files', item.newImage)
        updatingLandingImages.push({ index: i, rmImage: item.image, newImage: item.newImage.name })
        delete updatingLanding.value[i].newImage
      }
    }
    formData.append('updatingLandingImages', JSON.stringify(updatingLandingImages))
    formData.append('description', JSON.stringify(updatingLanding.value))
    console.log(31, initLanding.value.description)
    console.log(32, updatingLanding.value)

    await store.dispatch('page/savePage', formData)
    console.log(100, store.state.page.landing)

    // Update the local reactive reference with the new data from store
    if (initLanding.value?.description?.length > 0) {
      try {
        updatingLanding.value = initLanding.value.description
      } catch (error) {
        console.warn('Failed to parse updated landing page description:', error)
      }
    }
  }

  function updateAbout () {
    store.dispatch('page/savePage', {
      id: initAbout.value.id,
      description: updatingAboutText.value,
      title: updatingAboutTitle.value,
      pageName: 'about',
    })
  }

  function updateTerms () {
    store.dispatch('page/savePage', {
      id: initTerms.value.id,
      description: updatingTermsText.value,
      title: updatingTermsTitle.value,
      pageName: 'terms',
    })
  }

  function updatePrivacy () {
    store.dispatch('page/savePage', {
      id: initPrivacy.value.id,
      description: updatingPrivacyText.value,
      title: updatingPrivacyTitle.value,
      pageName: 'privacy',
    })
  }

  function updateSubscription (userId, payload) {
    const planId = 1
    const planTitle = 'ultimate'
    // payload = cancel sub or not
    if (payload) {
      store.dispatch('subscription/saveSubscriptionManually', {
        planId,
        planTitle,
        userId,
      })
    } else {
      store.dispatch('subscription/deleteSubscription', {
        userId,
      })
    }
  }

  function addAllUsersToAdminFriendlist () {
    store.dispatch('user/addAllUsersToAdminFriendlist')
  }

  async function exportUsers () {
    try {
      const response = await $axios.get('/admin/export/users', {
        responseType: 'blob',
      })
      const url = window.URL.createObjectURL(new Blob([response.data]))
      const link = document.createElement('a')
      link.href = url
      link.setAttribute('download', `users_export_${new Date().toISOString().split('T')[0]}.csv`)
      document.body.appendChild(link)
      link.click()
      link.remove()
      window.URL.revokeObjectURL(url)
    } catch (error) {
      console.error('Error exporting users:', error)
    }
  }

  async function exportEvents () {
    try {
      const response = await $axios.get('/admin/export/events', {
        responseType: 'blob',
      })
      const url = window.URL.createObjectURL(new Blob([response.data]))
      const link = document.createElement('a')
      link.href = url
      link.setAttribute('download', `events_export_${new Date().toISOString().split('T')[0]}.csv`)
      document.body.appendChild(link)
      link.click()
      link.remove()
      window.URL.revokeObjectURL(url)
    } catch (error) {
      console.error('Error exporting events:', error)
    }
  }

  const foundUsersWSucscription = ref([])

  watch(
    () => foundUsers.value,
    async targetUsers => {
      // Create a copy of foundUsers to work with
      const updatedUsers = [...foundUsers.value]

      for (const user of targetUsers) {
        try {
          const response = await $axios.get('/subscription/getSubscription', {
            params: { userId: user.id },
          })
          const subscriptionData = response.data?.payload // Make sure to access the data property
          const index = updatedUsers.findIndex(u => u.id === user.id)
          if (index !== -1) {
            // Update the copy instead of the original reactive property
            updatedUsers[index] = {
              ...subscriptionData,
              ...updatedUsers[index],
              subscriptionId: updatedUsers[index].id,
              isSubscriptionActive:
                subscriptionData?.active === true
                && subscriptionData.stripeSubscriptionId !== '0',
            }
          }
        } catch (error) {
          console.error('API call failed:', error)
        }
      }

      // Use nextTick to update foundUsers.value after the DOM update cycle
      await nextTick(() => {
        foundUsersWSucscription.value = updatedUsers
      })
    },
    { deep: true }, // Use deep watcher if foundUsers.value is an array of objects
  )

  onMounted(() => {
    store.commit('user/removeFoundUsers')
    store.dispatch('category/setCategories')
    store.dispatch('blog/setBlogs')

    store.dispatch('page/setPage', 'landing').then(() => {
      if (initLanding.value?.description?.length > 0) {
        try {
          updatingLanding.value = initLanding.value.description
        } catch (error) {
          console.warn('Failed to parse landing page description in admin dashboard:', error)
        }
      }
    })

    store.dispatch('page/setPage', 'about').then(() => {
      updatingAboutTitle.value = initAbout.value.title
      // Handle both HTML (from rich editor) and plain text (legacy)
      const content = initAbout.value.description?.content || initAbout.value.description || ''
      updatingAboutText.value = content
    })
    store.dispatch('page/setPage', 'terms').then(() => {
      updatingTermsTitle.value = initTerms.value.title
      const content = initTerms.value.description?.content || initTerms.value.description || ''
      updatingTermsText.value = content
    })
    store.dispatch('page/setPage', 'privacy').then(() => {
      updatingPrivacyTitle.value = initPrivacy.value.title
      const content = initPrivacy.value.description?.content || initPrivacy.value.description || ''
      updatingPrivacyText.value = content
    })
  })
</script>

<template>
  <v-container>
    <page-title :show-back-button="false" subtitle="Manage your site" title="Admin Panel" />
    <v-row justify="center">
      <v-col cols="12">
        <v-tabs v-model="tab" bg-color="primary" density="comfortable">
          <v-tab value="site">Site</v-tab>
          <v-tab value="blog">Blog</v-tab>
          <v-tab value="pages">Pages</v-tab>
        </v-tabs>

        <v-window v-model="tab">
          <v-window-item value="site">
            <v-row align="baseline" class="mt-3" justify="space-around">
              <v-col cols="12" md="5">
                <div class="d-flex justify-space-between">
                  <h3>Manage Category</h3>
                </div>

                <v-divider class="my-1" />

                <v-data-iterator
                  v-if="categories.length > 0"
                  :items="categories"
                  :items-per-page="10"
                  :search="categorySearch"
                >
                  <template #header>
                    <v-toolbar class="px-2">
                      <v-text-field
                        v-model="categorySearch"
                        clearable
                        density="compact"
                        hide-details
                        :min-width="250"
                        placeholder="Search categories"
                        prepend-inner-icon="mdi-magnify"
                        variant="solo"
                      />
                      <v-spacer />
                      <div>
                        <v-btn
                          v-if="xs"
                          color="primary"
                          density="compact"
                          icon="mdi-plus-circle-outline"
                          variant="text"
                          @click="newCategoryDialog = !newCategoryDialog"
                        />
                        <v-btn
                          v-else
                          color="primary"
                          variant="text"
                          @click="newCategoryDialog = !newCategoryDialog"
                        >
                          New Category
                        </v-btn>
                      </div>
                    </v-toolbar>
                  </template>

                  <template #default="{ items }">
                    <v-list class="pa-0">
                      <v-list-item
                        v-for="({ raw: item }, index) in items"
                        :key="item.id ?? index"
                        :title="item.name"
                      >
                        <template #append>
                          <v-btn
                            color="primary"
                            icon="mdi-pencil"
                            size="small"
                            variant="text"
                            @click="openEditCategoryDialog(item)"
                          />

                          <confirmation-dialog
                            popup-content="Are you sure?"
                            popup-title="Delete Category"
                            @confirm="deleteCategory(item.id)"
                          >
                            <template #activator="{ onClick }">
                              <v-btn
                                color="primary"
                                icon="mdi-close"
                                size="small"
                                variant="text"
                                @click="onClick"
                              />
                            </template>
                          </confirmation-dialog>
                        </template>
                      </v-list-item>
                    </v-list>
                  </template>

                  <template #footer="{ page, pageCount, setPage }">
                    <v-pagination
                      density="compact"
                      :length="pageCount"
                      :model-value="page"
                      :total-visible="3"
                      @update:model-value="setPage"
                    />
                  </template>
                </v-data-iterator>
                <no-items
                  v-else
                  action-icon="mdi-plus"
                  action-text="Create Category"
                  description="Create your first category to organize events and make them easier to discover."
                  icon="mdi-tag-outline"
                  :show-action="true"
                  title="No categories found"
                  @action="newCategoryDialog = true"
                />
              </v-col>
              <v-divider v-if="!xs" inset vertical />
              <v-col cols="12" md="5">
                <div class="d-flex justify-space-between align-center mt-5">
                  <h3>Manage User</h3>
                </div>
                <v-divider class="my-2" />

                <v-data-iterator
                  :items="foundUsersWSucscription"
                  :items-per-page="10"
                >
                  <template #header>
                    <v-text-field
                      v-model="searchingUser"
                      append-inner-icon="mdi-magnify"
                      class="mb-2 mb-md-4"
                      clearable
                      density="compact"
                      hide-details="auto"
                      label="Search by ID/Name/Email"
                      single-line
                      variant="solo"
                      @click:append-inner="searchUser"
                      @keyup.enter="searchUser"
                    />
                  </template>

                  <template #default="{ items }">
                    <v-list class="pa-0">
                      <v-list-item
                        v-for="({ raw: item }, index) in items"
                        :key="item.id ?? index"
                        :class="{ 'px-1': xs }"
                        link
                        @click="
                          $router.push({
                            name: 'wall',
                            params: { id: item.id || item.id },
                          })
                        "
                      >
                        <div class="d-flex justify-space-between align-center">
                          <name-card
                            container-class="clickable"
                            :img-size="60"
                            :is-detailed="true"
                            :profile="item"
                            rounded="circle"
                          />

                          <v-spacer />

                          <div class="text-center" @click.stop>
                            <v-checkbox
                              v-model="item.isSubscriptionActive"
                              color="primary"
                              hide-details
                              label="Premium?"
                              @update:model-value="
                                updateSubscription(item.id, $event)
                              "
                            />
                            <confirmation-dialog
                              popup-content="Are you sure?"
                              popup-title="Delete User"
                              @confirm="deleteUser(item.id)"
                            >
                              <template #activator="{ onClick }">
                                <v-btn
                                  v-if="xs"
                                  color="error"
                                  icon="mdi-delete"
                                  size="small"
                                  variant="text"
                                  @click="onClick"
                                />
                                <v-btn
                                  v-else
                                  color="error"
                                  size="small"
                                  @click="onClick"
                                >
                                  Remove
                                </v-btn>
                              </template>
                            </confirmation-dialog>
                          </div>
                        </div>
                        <v-divider v-if="index < items.length-1" class="mt-4" />
                      </v-list-item>
                    </v-list>
                  </template>

                  <template #footer="{ page, pageCount, setPage }">
                    <v-pagination
                      density="compact"
                      :length="pageCount"
                      :model-value="page"
                      :total-visible="3"
                      @update:model-value="setPage"
                    />
                  </template>

                  <template #no-data>
                    <no-items
                      description="Try adjusting your search terms or browse all users."
                      :full-page="true"
                      icon="mdi-account-search-outline"
                      title="No users found"
                    />
                  </template>
                </v-data-iterator>

                <div class="mt-5">
                  <h3>Add Everyone</h3>
                  <v-divider class="my-2" />
                  <v-btn
                    color="primary"
                    @click="addAllUsersToAdminFriendlist()"
                  >
                    Add as Friends
                  </v-btn>
                </div>

                <div class="mt-5">
                  <h3>Export Data</h3>
                  <v-divider class="my-2" />
                  <div class="d-flex flex-column flex-sm-row gap-2">
                    <v-btn
                      color="primary"
                      prepend-icon="mdi-file-excel"
                      @click="exportUsers"
                    >
                      Export User Data
                    </v-btn>
                    <v-btn
                      color="primary"
                      prepend-icon="mdi-file-excel"
                      @click="exportEvents"
                    >
                      Export Event Data
                    </v-btn>
                  </div>
                </div>
              </v-col>
            </v-row>
          </v-window-item>

          <v-window-item value="blog">
            <div class="d-flex justify-space-between align-center mt-5">
              <h3>Manage Blog</h3>
            </div>
            <v-divider class="my-1" />

            <v-data-iterator
              v-if="blogs.length > 0"
              :items="blogs"
              :items-per-page="10"
              :search="blogSearch"
            >
              <template #header>
                <v-toolbar class="px-2">
                  <v-text-field
                    v-model="blogSearch"
                    clearable
                    density="compact"
                    hide-details
                    :max-width="400"
                    placeholder="Search blogs"
                    prepend-inner-icon="mdi-magnify"
                    variant="solo"
                  />
                  <v-spacer />
                  <div>
                    <v-btn
                      v-if="xs"
                      color="primary"
                      density="compact"
                      icon="mdi-plus-circle-outline"
                      variant="text"
                      @click="openNewBlogDialog"
                    />
                    <v-btn
                      v-else
                      color="primary"
                      variant="text"
                      @click="openNewBlogDialog"
                    >
                      New Blog
                    </v-btn>
                  </div>
                </v-toolbar>
              </template>

              <template #default="{ items }">
                <v-list class="pa-0">
                  <v-list-item
                    v-for="({ raw: item }, index) in items"
                    :key="item.id ?? index"
                    class="pb-3"
                    :subtitle="formatDateFromTimestamp(item.createdAt)"
                    :title="item.title"
                  >
                    <template #append>
                      <v-btn
                        color="primary"
                        icon="mdi-pencil"
                        size="small"
                        variant="text"
                        @click="openEditBlogDialog(item)"
                      />

                      <confirmation-dialog
                        popup-content="Are you sure?"
                        popup-title="Delete Blog"
                        @confirm="deleteBlog(item.id, item.image)"
                      >
                        <template #activator="{ onClick }">
                          <v-btn
                            color="primary"
                            icon="mdi-close"
                            size="small"
                            variant="text"
                            @click="onClick"
                          />
                        </template>
                      </confirmation-dialog>
                    </template>
                  </v-list-item>
                </v-list>
              </template>

              <template #footer="{ page, pageCount, setPage }">
                <v-pagination
                  density="compact"
                  :length="pageCount"
                  :model-value="page"
                  :total-visible="3"
                  @update:model-value="setPage"
                />
              </template>
            </v-data-iterator>
            <no-items
              v-else
              action-icon="mdi-plus"
              action-text="Create Blog"
              description="There are no blog posts to manage. Create your first blog post to share updates and engage with your community."
              :full-page="true"
              icon="mdi-blog-outline"
              :show-action="true"
              title="No blogs listed"
              @action="openNewBlogDialog"
            />
          </v-window-item>
          <v-window-item value="pages">
            <v-expansion-panels>
              <v-expansion-panel>
                <v-expansion-panel-title>Landing</v-expansion-panel-title>
                <v-expansion-panel-text
                  v-if="updatingLanding && updatingLanding.length > 0"
                >
                  <v-card class="mb-4">
                    <v-card-title>Section 1</v-card-title>
                    <v-card-text>
                      <v-text-field
                        v-model="updatingLanding[0].title"
                        class="mb-2"
                        clearable
                        density="compact"
                        hide-details="auto"
                        label="Title"
                        required
                        :rules="[(v) => !!v || 'Title is required!']"
                        variant="solo"
                      />
                      <v-textarea
                        v-model="updatingLanding[0].description"
                        class="text-pre-wrap"
                        label="Description"
                        rows="10"
                        variant="solo"
                      />
                      <ImageManager
                        v-if="updatingLanding[0]?.image"
                        container-class="mt-2 mt-md-4"
                        :hide-delete="true"
                        :src="getPageImageUrl(updatingLanding[0]?.image)"
                      />
                      <v-file-upload
                        v-model="updatingLanding[0].newImage"
                        accept="image/*"
                        class="mt-2"
                        clearable
                        density="compact"
                        :hide-browse="false"
                        :rules="[
                          (v) =>
                            (Array.isArray(v) ? v : [v]).every((file) =>
                              isValidImage(file),
                            ) || 'Only jpeg/png allowed!',
                        ]"
                        show-size
                        title="Update Image"
                        variant=""
                      />
                    </v-card-text>
                  </v-card>
                  <v-card class="mb-4">
                    <v-card-title>Section 2</v-card-title>
                    <v-card-text>
                      <v-text-field
                        v-model="updatingLanding[1].title"
                        class="mb-2"
                        clearable
                        density="compact"
                        hide-details="auto"
                        label="Title"
                        required
                        :rules="[(v) => !!v || 'Title is required!']"
                        variant="solo"
                      />
                      <v-textarea
                        v-model="updatingLanding[1].description"
                        class="text-pre-wrap"
                        label="Description"
                        rows="10"
                        variant="solo"
                      />
                      <ImageManager
                        v-if="updatingLanding[1]?.image"
                        container-class="mt-2 mt-md-4"
                        :hide-delete="true"
                        :src="getPageImageUrl(updatingLanding[1]?.image)"
                      />
                      <v-file-upload
                        v-model="updatingLanding[1].newImage"
                        accept="image/*"
                        class="mt-2"
                        clearable
                        density="compact"
                        :hide-browse="false"
                        :rules="[
                          (v) =>
                            (Array.isArray(v) ? v : [v]).every((file) =>
                              isValidImage(file),
                            ) || 'Only jpeg/png allowed!',
                        ]"
                        show-size
                        title="Update Image"
                        variant=""
                      />
                    </v-card-text>
                  </v-card>
                  <v-card class="mb-4">
                    <v-card-title>Section 3</v-card-title>
                    <v-card-text>
                      <v-text-field
                        v-model="updatingLanding[2].title"
                        class="mb-2"
                        clearable
                        density="compact"
                        hide-details="auto"
                        label="Title"
                        required
                        :rules="[(v) => !!v || 'Title is required!']"
                        variant="solo"
                      />
                      <v-textarea
                        v-model="updatingLanding[2].description"
                        class="text-pre-wrap"
                        label="Description"
                        rows="10"
                        variant="solo"
                      />
                      <ImageManager
                        v-if="updatingLanding[2]?.image"
                        container-class="mt-2 mt-md-4"
                        :hide-delete="true"
                        :src="getPageImageUrl(updatingLanding[2]?.image)"
                      />
                      <v-file-upload
                        v-model="updatingLanding[2].newImage"
                        accept="image/*"
                        class="mt-2"
                        clearable
                        density="compact"
                        :hide-browse="false"
                        :rules="[
                          (v) =>
                            (Array.isArray(v) ? v : [v]).every((file) =>
                              isValidImage(file),
                            ) || 'Only jpeg/png allowed!',
                        ]"
                        show-size
                        title="Update Image"
                        variant=""
                      />
                    </v-card-text>
                  </v-card>
                  <v-card class="mb-4">
                    <v-card-title>Section 4</v-card-title>
                    <v-card-text>
                      <v-textarea
                        v-model="updatingLanding[3].description"
                        class="text-pre-wrap"
                        label="Description"
                        rows="10"
                        variant="solo"
                      />
                    </v-card-text>
                  </v-card>
                  <div class="d-flex justify-end mb-1">
                    <v-btn
                      color="primary"
                      :density="xs ? 'comfortable' : 'default'"
                      variant="text"
                      @click="handleUpdateLanding"
                    >Update
                    </v-btn>
                  </div>
                </v-expansion-panel-text>
              </v-expansion-panel>
              <v-expansion-panel>
                <v-expansion-panel-title>About Us</v-expansion-panel-title>
                <v-expansion-panel-text>
                  <v-text-field
                    v-model="updatingAboutTitle"
                    class="mb-2"
                    clearable
                    density="compact"
                    hide-details="auto"
                    label="Title"
                    required
                    :rules="[(v) => !!v || 'Title is required!']"
                    variant="solo"
                  />
                  <rich-text-editor
                    v-model="updatingAboutText"
                    placeholder="Start typing your About Us content..."
                  />
                  <div class="d-flex justify-end mb-1">
                    <v-btn
                      color="primary"
                      :density="xs ? 'comfortable' : 'default'"
                      variant="text"
                      @click="updateAbout"
                    >Update
                    </v-btn>
                  </div>
                </v-expansion-panel-text>
              </v-expansion-panel>
              <v-expansion-panel>
                <v-expansion-panel-title>Terms & Conditions
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                  <v-text-field
                    v-model="updatingTermsTitle"
                    class="mb-2"
                    clearable
                    density="compact"
                    hide-details="auto"
                    label="Title"
                    required
                    :rules="[(v) => !!v || 'Title is required!']"
                    variant="solo"
                  />
                  <rich-text-editor
                    v-model="updatingTermsText"
                    placeholder="Start typing your Terms & Conditions..."
                  />
                  <div class="d-flex justify-end mb-1">
                    <v-btn
                      color="primary"
                      :density="xs ? 'comfortable' : 'default'"
                      variant="text"
                      @click="updateTerms"
                    >Update
                    </v-btn>
                  </div>
                </v-expansion-panel-text>
              </v-expansion-panel>
              <v-expansion-panel>
                <v-expansion-panel-title>Privacy Policy
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                  <v-text-field
                    v-model="updatingPrivacyTitle"
                    class="mb-2"
                    clearable
                    density="compact"
                    hide-details="auto"
                    label="Title"
                    required
                    :rules="[(v) => !!v || 'Title is required!']"
                    variant="solo"
                  />
                  <rich-text-editor
                    v-model="updatingPrivacyText"
                    placeholder="Start typing your Privacy Policy..."
                  />
                  <div class="d-flex justify-end mb-1">
                    <v-btn
                      color="primary"
                      :density="xs ? 'comfortable' : 'default'"
                      variant="text"
                      @click="updatePrivacy"
                    >Update
                    </v-btn>
                  </div>
                </v-expansion-panel-text>
              </v-expansion-panel>
            </v-expansion-panels>
          </v-window-item>
        </v-window>
      </v-col>
    </v-row>
  </v-container>

  <v-dialog v-model="newCategoryDialog" width="400">
    <v-card>
      <v-card-title>
        <span>Create Category</span>
      </v-card-title>
      <v-card-text>
        <v-form
          ref="addCategoryForm"
          v-model="isAddCategoryFormValid"
          fast-fail
          @submit.prevent="addCategory"
        >
          <v-text-field
            v-model="newCategoryTitle"
            class="mt-2"
            clearable
            density="compact"
            hide-details="auto"
            label="Category Title"
            required
            :rules="[(v) => !!v || 'Title is required!']"
            variant="solo"
          />

          <v-card-actions>
            <v-spacer />
            <v-btn
              color="primary"
              :density="xs ? 'comfortable' : 'default'"
              type="submit"
            >Submit
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>

  <v-dialog v-model="editCategoryDialog" width="400">
    <v-card>
      <v-card-title>
        <span>Edit Category</span>
      </v-card-title>
      <v-card-text>
        <v-form
          ref="editCategoryForm"
          v-model="isEditCategoryFormValid"
          fast-fail
          @submit.prevent="
            editCategory(editingCategory, index)
          "
        >
          <v-text-field
            v-model="editingCategory.name"
            class="mt-2"
            clearable
            density="compact"
            hide-details="auto"
            label="Category Title"
            required
            :rules="[(v) => !!v || 'Title is required!']"
            variant="solo"
          />

          <v-card-actions>
            <v-spacer />
            <v-btn
              color="primary"
              :density="xs ? 'comfortable' : 'default'"
              type="submit"
            >Submit
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>

  <v-dialog v-model="newBlogDialog" width="800">
    <v-card>
      <v-card-title>
        <span>Create Blog</span>
      </v-card-title>
      <v-card-text>
        <v-form
          ref="addBlogForm"
          v-model="isAddBlogFormValid"
          fast-fail
          @submit.prevent="addBlog"
        >
          <v-text-field
            v-model="newBlog.title"
            class="mt-2"
            clearable
            density="compact"
            hide-details="auto"
            label="Blog Title"
            required
            :rules="[(v) => !!v || 'Title is required!']"
            variant="solo"
          />

          <div class="mt-2">
            <label class="text-body-2 text-medium-emphasis mb-2 d-block">Description</label>
            <rich-text-editor
              v-model="newBlog.description"
              placeholder="Write your blog post..."
            />
          </div>

          <v-file-upload
            v-model="newBlog.image"
            accept="image/*"
            class="mt-2 mt-md-4"
            clearable
            density="compact"
            :hide-browse="false"
            :rules="[
              (v) =>
                (Array.isArray(v) ? v : [v]).every((file) =>
                  isValidImage(file),
                ) || 'Only jpeg/png allowed!',
            ]"
            show-size
            title="Upload Image"
            variant=""
          />

          <v-card-actions>
            <v-spacer />
            <v-btn
              color="primary"
              :density="xs ? 'comfortable' : 'default'"
              type="submit"
            >Submit
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>

  <v-dialog v-model="editBlogDialog" width="800">
    <v-card>
      <v-card-title>
        <span>Edit Blog</span>
      </v-card-title>
      <v-card-text>
        <v-form
          ref="editBlogForm"
          v-model="isEditBlogFormValid"
          fast-fail
          @submit.prevent="editBlog"
        >
          <v-text-field
            v-model="editingBlog.title"
            class="mt-2"
            clearable
            density="compact"
            hide-details="auto"
            label="Blog Title"
            required
            :rules="[(v) => !!v || 'Title is required!']"
            variant="solo"
          />

          <div class="mt-2">
            <label class="text-body-2 text-medium-emphasis mb-2 d-block">Description</label>
            <rich-text-editor
              v-model="editingBlog.description"
              placeholder="Write your blog post..."
            />
          </div>

          <ImageManager
            v-if="editingBlog.image"
            container-class="mt-2 mt-md-4"
            :hide-delete="true"
            :src="getBlogImageUrl(editingBlog?.image)"
          />
          <v-file-upload
            v-model="editingBlog.newImage"
            accept="image/*"
            class="mt-2"
            clearable
            density="compact"
            :hide-browse="false"
            :rules="[
              (v) =>
                (Array.isArray(v) ? v : [v]).every((file) =>
                  isValidImage(file),
                ) || 'Only jpeg/png allowed!',
            ]"
            show-size
            title="Update Image"
            variant=""
          />

          <v-card-actions>
            <v-spacer />
            <v-btn
              color="primary"
              :density="xs ? 'comfortable' : 'default'"
              type="submit"
            >Submit
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<style scoped></style>
