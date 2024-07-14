<script setup>
import { computed, nextTick, onMounted, reactive, ref, watch } from "vue";
import NameCard from "@/components/NameCard.vue";
import { useStore } from "vuex";
import {
  formatDateFromTimestamp,
  getBlogImageUrl,
  getPageImageUrl,
  isValidImage,
} from "@/util";
import PageTitle from "@/components/PageTitle.vue";
import { useDisplay } from "vuetify";
import RemoveEntity from "@/components/RemoveEntity.vue";
import $axios from "@/plugins/axios";

const { mobile } = useDisplay();
const store = useStore();
const tab = ref("site");

const blogs = computed(() => store.state.blog.blogs);
const categories = computed(() => store.state.category.categories);
const foundUsers = computed(() => store.state.cuser.foundUsers);

const initLanding = computed(() => store.state.page.landing);
const initAbout = computed(() => store.state.page.about);
const initPrivacy = computed(() => store.state.page.privacy);
const initTerms = computed(() => store.state.page.terms);

const newCategoryDialog = ref(false);
const editCategoryDialog = ref(false);
const newBlogDialog = ref(false);
const editBlogDialog = ref(false);

const searchingUser = ref(null);

const updatingAboutTitle = ref(null);
const updatingAboutText = ref(null);
const updatingTermsTitle = ref(null);
const updatingTermsText = ref(null);
const updatingPrivacyTitle = ref(null);
const updatingPrivacyText = ref(null);

const newCategoryTitle = ref(null);

const addCategoryForm = ref(null);
const isAddCategoryFormValid = ref(true);

const addCategory = async () => {
  await addCategoryForm.value.validate();
  if (!isAddCategoryFormValid.value) return;

  const newCategory = { name: newCategoryTitle.value };
  store.dispatch("category/addCategory", newCategory).then(() => {
    newCategoryDialog.value = false;
  });
};

let editingCategory = reactive({ id: null, name: null });

const openEditCategoryDialog = (item) => {
  Object.assign(editingCategory, item);
};

const editCategoryForm = ref(null);
const isEditCategoryFormValid = ref(true);

const editCategory = async (item) => {
  // await editCategoryForm?.value?.[index].validate();
  // if (!isEditCategoryFormValid.value) return;
  if (!item.name) {
    isEditCategoryFormValid.value = false;
    return;
  }
  store.dispatch("category/editCategory", item).then(() => {
    editCategoryDialog.value = false;
    editingCategory = { id: null, name: null };
  });
};

const blogInit = {
  title: null,
  description: null,
  image: null,
};
const newBlog = reactive({ ...blogInit });

const handleBlogImageChange = (files) => {
  newBlog.image = files;
};
const openNewBlogDialog = () => {
  Object.assign(newBlog, blogInit);
  newBlogDialog.value = !newBlogDialog.value;
};
const addBlogForm = ref(null);
const isAddBlogFormValid = ref(true);

const addBlog = async () => {
  await addBlogForm.value.validate();
  if (!isAddBlogFormValid.value) return;

  const formData = new FormData();
  formData.append("title", newBlog.title);
  formData.append("description", newBlog.description);
  formData.append("files", newBlog.image);
  store.dispatch("blog/addBlog", formData).then(() => {
    newBlogDialog.value = false;
  });
};

const editingBlog = reactive({ ...blogInit, id: null });

const openEditBlogDialog = (item) => {
  editBlogDialog.value = !editBlogDialog.value;
  Object.assign(editingBlog, { ...item, newImage: null });
};
const handleEditBlogImageChange = (files) => {
  editingBlog.newImage = files;
};

const editBlogForm = ref(null);
const isEditBlogFormValid = ref(true);

const editBlog = async () => {
  // await editBlogForm.value.validate();
  // if (!isEditBlogFormValid.value) return;

  if (!editingBlog.title || !editingBlog.description) {
    isEditBlogFormValid.value = false;
    return;
  }

  const formData = new FormData();
  formData.append("id", editingBlog.id);
  formData.append("title", editingBlog.title);
  formData.append("description", editingBlog.description);

  if (editingBlog.newImage) {
    formData.append("files", editingBlog.newImage);
    if (editingBlog.image) formData.append("rmImage", editingBlog.image);
  }
  store.dispatch("blog/editBlog", formData).then(() => {
    editBlogDialog.value = !editBlogDialog.value;
  });
};

const deleteBlog = (blogId, rmImage) => {
  store.dispatch("blog/deleteBlog", { blogId, rmImage });
};

const deleteCategory = (categoryId) => {
  store.dispatch("category/deleteCategory", categoryId);
};

const searchUser = () => {
  store.dispatch("cuser/searchUser", searchingUser.value);
};

const deleteUser = (id) => {
  store.dispatch("cuser/deleteUser", id);
};
const updatingLanding = ref([
  { title: null, description: null, image: null },
  { title: null, description: null, image: null },
  { title: null, description: null, image: null },
  { title: null, description: null, image: null },
]);
const handleLandingImageChange = (index, files) => {
  updatingLanding.value[index].image = files;
};
const handleUpdateLanding = () => {
  const formData = new FormData();
  formData.append("id", initLanding.value.id);
  formData.append("title", "Landing");
  formData.append("description", JSON.stringify(updatingLanding.value));
  formData.append("pageName", "landing");
  formData.append("descriptionInit", initLanding.value.description);

  updatingLanding.value.forEach((item) => {
    if (item.image instanceof File) formData.append("files", item.image);
  });

  store.dispatch("page/updateLanding", formData);
};

const updateAbout = () => {
  store.dispatch("page/updateAbout", {
    id: initAbout.value.id,
    description: updatingAboutText.value,
    title: updatingAboutTitle.value,
    pageName: "about",
  });
};

const updateTerms = () => {
  store.dispatch("page/updateTerms", {
    id: initTerms.value.id,
    description: updatingTermsText.value,
    title: updatingTermsTitle.value,
    pageName: "terms",
  });
};

const updatePrivacy = () => {
  store.dispatch("page/updatePrivacy", {
    id: initPrivacy.value.id,
    description: updatingPrivacyText.value,
    title: updatingPrivacyTitle.value,
    pageName: "privacy",
  });
};

const updateSubscription = (userId, payload) => {
  const planId = 1;
  const planTitle = "ultimate";
  //payload = cancel sub or not
  if (payload) {
    store.dispatch("subscription/saveSubscriptionManually", {
      planId,
      planTitle,
      userId,
    });
  } else {
    store.dispatch("subscription/deleteSubscription", {
      userId,
    });
  }
};

const addAllUsersToAdminFriendlist = () => {
  store.dispatch("cuser/addAllUsersToAdminFriendlist");
};

const foundUsersWSucscription = ref([]);

watch(
  () => foundUsers.value,
  async (targetUsers) => {
    // Create a copy of foundUsers to work with
    const updatedUsers = [...foundUsers.value];

    for (const user of targetUsers) {
      try {
        const response = await $axios.get("/api/subscription/getSubscription", {
          params: { userId: user.id },
        });
        const subscriptionData = response.data?.payload; // Make sure to access the data property
        const index = updatedUsers.findIndex((u) => u.id === user.id);
        if (index !== -1) {
          // Update the copy instead of the original reactive property
          updatedUsers[index] = {
            ...subscriptionData,
            ...updatedUsers[index],
            subscriptionId: updatedUsers[index].id,
            isSubscriptionActive:
              subscriptionData?.active === 1 &&
              subscriptionData.stripe_subscription_id !== "0",
          };
        }
      } catch (error) {
        console.error("API call failed:", error);
      }
    }

    // Use nextTick to update foundUsers.value after the DOM update cycle
    await nextTick(() => {
      foundUsersWSucscription.value = updatedUsers;
    });
  },
  { deep: true } // Use deep watcher if foundUsers.value is an array of objects
);

onMounted(() => {
  store.commit("cuser/removeFoundUsers");
  store.dispatch("category/setCategories");
  store.dispatch("blog/setBlogs");

  store.dispatch("page/setLanding").then(() => {
    if (initLanding.value?.description?.length > 0) {
      updatingLanding.value = JSON.parse(initLanding.value.description);
    }
  });

  store.dispatch("page/setAbout").then(() => {
    updatingAboutTitle.value = initAbout.value.title;
    updatingAboutText.value = initAbout.value.description;
  });
  store.dispatch("page/setTerms").then(() => {
    updatingTermsTitle.value = initTerms.value.title;
    updatingTermsText.value = initTerms.value.description;
  });
  store.dispatch("page/setPrivacy").then(() => {
    updatingPrivacyTitle.value = initPrivacy.value.title;
    updatingPrivacyText.value = initPrivacy.value.description;
  });
});
</script>

<template>
  <v-container>
    <page-title title="Admin Panel"></page-title>
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

                  <v-dialog v-model="newCategoryDialog" width="400">
                    <template v-slot:activator="{ props }">
                      <v-btn
                        v-if="mobile"
                        color="primary"
                        density="compact"
                        icon="mdi-plus-circle-outline"
                        v-bind="props"
                        variant="text"
                      >
                      </v-btn>
                      <v-btn
                        v-else
                        color="primary"
                        v-bind="props"
                        variant="text"
                      >
                        New Category
                      </v-btn>
                    </template>

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
                            :rules="[(v) => !!v || 'Title is required!']"
                            class="mt-2"
                            clearable
                            density="compact"
                            hide-details="auto"
                            label="Category Title"
                            required
                            variant="solo"
                          ></v-text-field>

                          <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn
                              :density="mobile ? 'comfortable' : 'default'"
                              color="primary"
                              type="submit"
                              >Submit
                            </v-btn>
                          </v-card-actions>
                        </v-form>
                      </v-card-text>
                    </v-card>
                  </v-dialog>
                </div>

                <v-divider class="my-1"></v-divider>

                <v-list>
                  <v-list-item
                    v-for="(item, index) in categories"
                    :key="index"
                    :title="item.name"
                  >
                    <template v-slot:append>
                      <v-dialog v-model="editCategoryDialog" width="400">
                        <template v-slot:activator="{ props }">
                          <v-btn
                            color="primary"
                            icon="mdi-pencil"
                            size="small"
                            v-bind="props"
                            variant="text"
                            @click="openEditCategoryDialog(item)"
                          >
                          </v-btn>
                        </template>

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
                                :rules="[(v) => !!v || 'Title is required!']"
                                class="mt-2"
                                clearable
                                density="compact"
                                hide-details="auto"
                                label="Category Title"
                                required
                                variant="solo"
                              ></v-text-field>

                              <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn
                                  :density="mobile ? 'comfortable' : 'default'"
                                  color="primary"
                                  type="submit"
                                  >Submit
                                </v-btn>
                              </v-card-actions>
                            </v-form>
                          </v-card-text>
                        </v-card>
                      </v-dialog>

                      <v-btn
                        color="primary"
                        icon="mdi-close"
                        size="small"
                        variant="text"
                        @click="deleteCategory(item.id)"
                      >
                      </v-btn>
                    </template>
                  </v-list-item>
                </v-list>
              </v-col>
              <v-divider v-if="!mobile" inset vertical></v-divider>
              <v-col cols="12" md="5">
                <div class="d-flex justify-space-between align-center mt-5">
                  <h3>Manage User</h3>
                  <v-spacer v-if="!mobile"></v-spacer>
                  <v-text-field
                    v-model="searchingUser"
                    append-inner-icon="mdi-magnify"
                    class="flex-grow-1 ml-5 ml-md-1 pa-0"
                    clearable
                    density="compact"
                    hide-details="auto"
                    label="Search by ID/Name/Email"
                    single-line
                    variant="solo"
                    @click:append-inner="searchUser"
                    @keyup.enter="searchUser"
                  ></v-text-field>
                </div>
                <v-divider class="my-2"></v-divider>

                <v-list v-if="foundUsersWSucscription.length > 0">
                  <v-list-item
                    v-for="(item, index) in foundUsersWSucscription"
                    :key="index"
                    :class="{ 'px-1': mobile }"
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
                        :img-size="60"
                        :is-detailed="true"
                        :profile="item"
                        container-class="clickable"
                        img-class="rounded-circle"
                      ></name-card>

                      <v-spacer></v-spacer>

                      <div class="text-center" @click.stop>
                        <v-checkbox
                          v-model="item.isSubscriptionActive"
                          color="primary"
                          hide-details
                          label="Premium?"
                          @update:modelValue="
                            updateSubscription(item.id, $event)
                          "
                        ></v-checkbox>
                        <remove-entity
                          :id="item.id"
                          size="small"
                          @remove-entity="deleteUser"
                        ></remove-entity>
                      </div>
                    </div>
                  </v-list-item>
                </v-list>
                <h4 v-else class="py-5 text-center">
                  No users in search list!
                </h4>

                <div class="mt-5">
                  <h3>Add Everyone</h3>
                  <v-divider class="my-2"></v-divider>
                  <v-btn
                    color="primary"
                    @click="addAllUsersToAdminFriendlist()"
                  >
                    Add as Friends
                  </v-btn>
                </div>
              </v-col>
            </v-row>
          </v-window-item>

          <v-window-item value="blog">
            <div class="d-flex justify-space-between align-center mt-5">
              <h3>Manage Blog</h3>
              <v-btn
                v-if="mobile"
                color="primary"
                density="compact"
                icon="mdi-plus-circle-outline"
                variant="text"
                @click="openNewBlogDialog"
              >
              </v-btn>
              <v-btn
                v-else
                color="primary"
                variant="text"
                @click="openNewBlogDialog"
              >
                New Blog
              </v-btn>
            </div>
            <v-divider class="my-1"></v-divider>

            <v-list v-if="blogs.length > 0">
              <v-list-item
                v-for="(item, index) in blogs"
                :key="index"
                :subtitle="formatDateFromTimestamp(item.created_at)"
                :title="item.title"
                class="pb-3"
              >
                <template v-slot:append>
                  <v-btn
                    color="primary"
                    icon="mdi-pencil"
                    size="small"
                    variant="text"
                    @click="openEditBlogDialog(item)"
                  >
                  </v-btn>

                  <v-btn
                    color="primary"
                    icon="mdi-close"
                    size="small"
                    variant="text"
                    @click="deleteBlog(item.id, item.image)"
                  >
                  </v-btn>
                </template>
              </v-list-item>
            </v-list>
            <h4 v-else class="text-center py-5">No blogs listed!</h4>
          </v-window-item>

          <v-window-item value="pages">
            <v-expansion-panels>
              <v-expansion-panel>
                <v-expansion-panel-title>Landing</v-expansion-panel-title>
                <v-expansion-panel-text
                  v-if="updatingLanding && updatingLanding.length > 0"
                >
                  <h3 class="pa-1 mt-6">Section 1:</h3>
                  <v-text-field
                    v-model="updatingLanding[0].title"
                    :rules="[(v) => !!v || 'Title is required!']"
                    class="mb-2"
                    clearable
                    density="compact"
                    hide-details="auto"
                    label="Title"
                    required
                    variant="solo"
                  ></v-text-field>
                  <v-textarea
                    v-model="updatingLanding[0].description"
                    class="text-pre-wrap"
                    label="Description"
                    rows="10"
                    variant="solo"
                  ></v-textarea>
                  <div class="d-flex align-center">
                    <v-avatar
                      :image="getPageImageUrl(updatingLanding[0].image)"
                      rounded="sm"
                      size="x-large"
                    ></v-avatar>
                    <v-file-input
                      :rules="[
                        (v) =>
                          !v ||
                          (Array.isArray(v) ? v : [v]).every(
                            (file) => file.size < 25 * 1024 * 1024
                          ) ||
                          'Max file size is 25MB!',
                        (v) =>
                          (Array.isArray(v) ? v : [v]).every((file) =>
                            isValidImage(file)
                          ) || 'Only jpeg/png allowed!',
                      ]"
                      accept="image/*"
                      class="mx-1"
                      clearable
                      density="compact"
                      hide-details
                      label="Section 1 image"
                      prepend-icon=""
                      prepend-inner-icon="mdi-camera"
                      variant="solo-filled"
                      @update:modelValue="handleLandingImageChange(0, $event)"
                      @click:clear="updatingLanding[0].image = null"
                    >
                    </v-file-input>
                  </div>
                  <h3 class="pa-1 mt-6">Section 2:</h3>
                  <v-text-field
                    v-model="updatingLanding[1].title"
                    :rules="[(v) => !!v || 'Title is required!']"
                    class="mb-2"
                    clearable
                    density="compact"
                    hide-details="auto"
                    label="Title"
                    required
                    variant="solo"
                  ></v-text-field>
                  <v-textarea
                    v-model="updatingLanding[1].description"
                    class="text-pre-wrap"
                    label="Description"
                    rows="10"
                    variant="solo"
                  ></v-textarea>
                  <div class="d-flex align-center">
                    <v-avatar
                      :image="getPageImageUrl(updatingLanding[1].image)"
                      rounded="sm"
                      size="x-large"
                    ></v-avatar>
                    <v-file-input
                      :rules="[
                        (v) =>
                          !v ||
                          (Array.isArray(v) ? v : [v]).every(
                            (file) => file.size < 25 * 1024 * 1024
                          ) ||
                          'Max file size is 25MB!',
                        (v) =>
                          (Array.isArray(v) ? v : [v]).every((file) =>
                            isValidImage(file)
                          ) || 'Only jpeg/png allowed!',
                      ]"
                      accept="image/*"
                      class="mx-1"
                      clearable
                      density="compact"
                      hide-details
                      label="Section 2 image"
                      prepend-icon=""
                      prepend-inner-icon="mdi-camera"
                      variant="solo-filled"
                      @update:modelValue="handleLandingImageChange(1, $event)"
                      @click:clear="updatingLanding[1].image = null"
                    >
                    </v-file-input>
                  </div>
                  <h3 class="pa-1 mt-6">Section 3:</h3>
                  <v-text-field
                    v-model="updatingLanding[2].title"
                    :rules="[(v) => !!v || 'Title is required!']"
                    class="mb-2"
                    clearable
                    density="compact"
                    hide-details="auto"
                    label="Title"
                    required
                    variant="solo"
                  ></v-text-field>
                  <v-textarea
                    v-model="updatingLanding[2].description"
                    class="text-pre-wrap"
                    label="Description"
                    rows="10"
                    variant="solo"
                  ></v-textarea>
                  <div class="d-flex align-center">
                    <v-avatar
                      :image="getPageImageUrl(updatingLanding[2].image)"
                      rounded="sm"
                      size="x-large"
                    ></v-avatar>
                    <v-file-input
                      :rules="[
                        (v) =>
                          !v ||
                          (Array.isArray(v) ? v : [v]).every(
                            (file) => file.size < 25 * 1024 * 1024
                          ) ||
                          'Max file size is 25MB!',
                        (v) =>
                          (Array.isArray(v) ? v : [v]).every((file) =>
                            isValidImage(file)
                          ) || 'Only jpeg/png allowed!',
                      ]"
                      accept="image/*"
                      class="mx-1"
                      clearable
                      density="compact"
                      hide-details
                      label="Section 3 image"
                      prepend-icon=""
                      prepend-inner-icon="mdi-camera"
                      variant="solo-filled"
                      @update:modelValue="handleLandingImageChange(2, $event)"
                      @click:clear="updatingLanding[2].image = null"
                    >
                    </v-file-input>
                  </div>
                  <h3 class="pa-1 mt-6">Section 4:</h3>
                  <v-textarea
                    v-model="updatingLanding[3].description"
                    class="text-pre-wrap"
                    label="Description"
                    rows="10"
                    variant="solo"
                  ></v-textarea>
                  <div class="d-flex justify-end mb-1">
                    <v-btn
                      :density="mobile ? 'comfortable' : 'default'"
                      color="primary"
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
                    :rules="[(v) => !!v || 'Title is required!']"
                    class="mb-2"
                    clearable
                    density="compact"
                    hide-details="auto"
                    label="Title"
                    required
                    variant="solo"
                  ></v-text-field>
                  <v-textarea
                    v-model="updatingAboutText"
                    class="text-pre-wrap"
                    label="Edit About Us"
                    rows="10"
                    variant="solo"
                  ></v-textarea>
                  <div class="d-flex justify-end mb-1">
                    <v-btn
                      :density="mobile ? 'comfortable' : 'default'"
                      color="primary"
                      variant="text"
                      @click="updateAbout"
                      >Update
                    </v-btn>
                  </div>
                </v-expansion-panel-text>
              </v-expansion-panel>
              <v-expansion-panel>
                <v-expansion-panel-title
                  >Terms & Conditions
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                  <v-text-field
                    v-model="updatingTermsTitle"
                    :rules="[(v) => !!v || 'Title is required!']"
                    class="mb-2"
                    clearable
                    density="compact"
                    hide-details="auto"
                    label="Title"
                    required
                    variant="solo"
                  ></v-text-field>
                  <v-textarea
                    v-model="updatingTermsText"
                    class="text-pre-wrap"
                    label="Edit Terms & Conditions"
                    rows="10"
                    variant="solo"
                  ></v-textarea>
                  <div class="d-flex justify-end mb-1">
                    <v-btn
                      :density="mobile ? 'comfortable' : 'default'"
                      color="primary"
                      variant="text"
                      @click="updateTerms"
                      >Update
                    </v-btn>
                  </div>
                </v-expansion-panel-text>
              </v-expansion-panel>
              <v-expansion-panel>
                <v-expansion-panel-title
                  >Privacy Policy
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                  <v-text-field
                    v-model="updatingPrivacyTitle"
                    :rules="[(v) => !!v || 'Title is required!']"
                    class="mb-2"
                    clearable
                    density="compact"
                    hide-details="auto"
                    label="Title"
                    required
                    variant="solo"
                  ></v-text-field>
                  <v-textarea
                    v-model="updatingPrivacyText"
                    class="text-pre-wrap"
                    label="Edit Privacy Policy"
                    rows="10"
                    variant="solo"
                  ></v-textarea>
                  <div class="d-flex justify-end mb-1">
                    <v-btn
                      :density="mobile ? 'comfortable' : 'default'"
                      color="primary"
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
            :rules="[(v) => !!v || 'Title is required!']"
            class="mt-2"
            clearable
            density="compact"
            hide-details="auto"
            label="Blog Title"
            required
            variant="solo"
          ></v-text-field>

          <v-textarea
            v-model="newBlog.description"
            :rules="[(v) => !!v || 'Description is required!']"
            class="mt-2 text-pre-wrap"
            hide-details="auto"
            label="Description"
            rows="8"
            variant="solo"
          ></v-textarea>

          <v-file-input
            :rules="[
              (v) =>
                (Array.isArray(v) ? v : [v]).every((file) =>
                  isValidImage(file)
                ) || 'Only jpeg/png allowed!',
            ]"
            accept="image/*"
            class="mt-2"
            clearable
            density="compact"
            label="Upload Image"
            prepend-icon=""
            prepend-inner-icon="mdi-camera"
            show-size
            variant="solo"
            @update:modelValue="handleBlogImageChange"
          >
            <template v-slot:selection="{ fileNames }">
              <template v-for="fileName in fileNames" :key="fileName">
                <v-chip class="me-2" color="primary" label size="small">
                  {{ fileName }}
                </v-chip>
              </template>
            </template>
          </v-file-input>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              :density="mobile ? 'comfortable' : 'default'"
              color="primary"
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
            :rules="[(v) => !!v || 'Title is required!']"
            class="mt-2"
            clearable
            density="compact"
            hide-details="auto"
            label="Blog Title"
            required
            variant="solo"
          ></v-text-field>

          <v-textarea
            v-model="editingBlog.description"
            :rules="[(v) => !!v || 'Description is required!']"
            class="mt-2 text-pre-wrap"
            hide-details="auto"
            label="Description"
            rows="8"
            variant="solo"
          ></v-textarea>

          <div class="d-flex align-center mt-3">
            <v-avatar
              :image="getBlogImageUrl(editingBlog?.image)"
              rounded="sm"
              size="x-large"
            ></v-avatar>
            <v-file-input
              :rules="[(v) => isValidImage(v) || 'Only jpeg/png allowed!']"
              accept="image/*"
              class="ml-2"
              clearable
              density="compact"
              hide-details="auto"
              label="Upload image"
              prepend-icon=""
              prepend-inner-icon="mdi-camera"
              show-size
              variant="solo"
              @update:modelValue="handleEditBlogImageChange"
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

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              :density="mobile ? 'comfortable' : 'default'"
              color="primary"
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
