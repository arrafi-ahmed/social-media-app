<script setup>
  import { computed, reactive, ref } from 'vue'
  import { useDisplay, useTheme } from 'vuetify'
  import { useStore } from 'vuex'
  import DatePicker from '@/components/DatePicker.vue'

  const { mobile } = useDisplay()
  const theme = useTheme()
  const store = useStore()

  const emit = defineEmits(['findEvents', 'resetFindEvents', 'sortEvents'])
  const form = ref(null)
  const isFormValid = ref(true)
  const allEventCategories = computed(() =>
    store.state.category.categories.map(item => item.name),
  )
  const settings = computed(() => store.state.user.settings)
  const findForm = reactive({
    searchKeyword: null,
    dates: [],
    category: null,
    sort: settings.value?.sort,
  })

  const sortIcon = computed(() =>
    findForm.sort === 'ASC'
      ? 'mdi-sort-reverse-variant'
      : findForm.sort === 'DESC'
        ? 'mdi-sort-variant'
        : findForm.sort === 'LATEST'
          ? 'mdi-sort-clock-descending-outline'
          : null,
  )

  async function handleFindEvents () {
    await form.value.validate()
    if (!isFormValid.value) return

    // Derive range boundaries from dates array (handles single or range)
    let startDate = null
    let endDate = null
    if (Array.isArray(findForm.dates) && findForm.dates.length > 0) {
      const sorted = [...findForm.dates].sort()
      startDate = sorted[0]
      endDate = sorted.at(-1)
    }

    const payload = {
      searchKeyword: findForm.searchKeyword,
      startDate,
      endDate,
      category: findForm.category,
      sort: findForm.sort,
    }

    emit('findEvents', payload)
  }

  function resetForm () {
    form.value.reset()
    emit('resetFindEvents')
  }

  // let sort = ref(settings.value?.sort);
  function handleSort (sortInput) {
    findForm.sort = sortInput
    emit('sortEvents', findForm)
  }
</script>

<template>
  <v-form
    ref="form"
    v-model="isFormValid"
    class="rounded event-form px-3"
    :class="{ 'flex-sticky top-60': !mobile }"
    @submit.prevent="handleFindEvents"
  >
    <v-card elevation="0" variant="flat">
      <v-container>
        <v-row align="center" no-gutters>
          <v-col class="d-flex" cols="12" md="11">
            <v-row no-gutters>
              <v-col cols="12" md="4">
                <v-text-field
                  v-model="findForm.searchKeyword"
                  class="mb-3 mb-md-0 mr-0 mr-md-2"
                  clearable
                  color="primary"
                  density="comfortable"
                  hide-details
                  label="Search"
                  @click-clear="findForm.searchKeyword = null"
                />
              </v-col>
              <v-col cols="12" md="4">
                <v-date-input
                  v-model="findForm.dates"
                  class="mb-3 mb-md-0 mr-0 mr-md-2"
                  clearable
                  color="primary"
                  density="comfortable"
                  hide-details
                  label="Start & End Date"
                  multiple="range"
                  prepend-icon=""
                  @click-clear="findForm.dates = []"
                />
              </v-col>
              <v-col cols="12" md="4">
                <v-select
                  v-model="findForm.category"
                  class="mb-3 mb-md-0 mr-0 mr-md-2"
                  clearable
                  density="comfortable"
                  hide-details
                  :items="allEventCategories"
                  label="Category"
                />
              </v-col>
            </v-row>
          </v-col>
          <v-col class="text-center d-flex align-center" cols="12" md="1">
            <v-btn
              class="ml-2 mr-sm-1 ml-md-0 rounded flex-grow-1"
              color="primary"
              :density="mobile ? 'comfortable' : 'default'"
              icon="mdi-magnify"
              type="submit"
            />
            <v-menu>
              <template #activator="{ props }">
                <v-btn
                  density="comfortable"
                  icon="mdi-dots-vertical"
                  v-bind="props"
                  :ripple="false"
                  variant="text"
                />
              </template>
              <v-list density="compact">
                <v-list-item
                  link
                  :prepend-icon="sortIcon"
                  title="Sort"
                >
                  <template #append>
                    <v-icon icon="mdi-menu-right" size="small" />
                  </template>

                  <v-menu activator="parent" :open-on-focus="false" open-on-hover submenu>
                    <v-list density="compact">
                      <!--              LATEST-->
                      <v-list-item
                        link
                        prepend-icon="mdi-sort-clock-descending-outline"
                        title="Recent Posts"
                        @click="handleSort('LATEST')"
                      />
                      <!--              DESC-->
                      <v-list-item
                        link
                        prepend-icon="mdi-sort-variant"
                        title="Newest Events First"
                        @click="handleSort('DESC')"
                      />
                      <!--              ASC-->
                      <v-list-item
                        link
                        prepend-icon="mdi-sort-reverse-variant"
                        title="Oldest Events First"
                        @click="handleSort('ASC')"
                      />
                    </v-list>
                  </v-menu>
                </v-list-item>
                <v-list-item
                  link
                  prepend-icon="mdi-restore"
                  title="Reset"
                  @click="resetForm"
                />
              </v-list>
            </v-menu>
          </v-col>
        </v-row>
      </v-container>
    </v-card>
  </v-form>
</template>

<style>
.event-form .mdi-close-circle{
  position: absolute;
  right: 2px;
}
.event-form .mdi-menu-down{
  position: absolute;
  right: 20px;
}
</style>
