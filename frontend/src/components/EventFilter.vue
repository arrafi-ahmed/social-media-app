<script setup>
  import { computed, reactive, ref, watch } from 'vue'
  import { useDisplay, useTheme } from 'vuetify'
  import { useStore } from 'vuex'

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
    category: null,
    sort: settings.value?.sort,
  })

  // Date mode controls
  const isRangeMode = ref(true) // true = range mode, false = single date mode
  const singleDateType = ref('start') // 'start' or 'end' when in single mode
  const startDateValue = ref(null)
  const endDateValue = ref(null)

  // v-model for date input - must be array when multiple="range", single value when multiple=false
  const dateInputValue = ref([])

  const sortIcon = computed(() =>
    findForm.sort === 'ASC'
      ? 'mdi-sort-reverse-variant'
      : findForm.sort === 'DESC'
        ? 'mdi-sort-variant'
        : findForm.sort === 'LATEST'
          ? 'mdi-sort-clock-descending-outline'
          : null,
  )

  // Format date to YYYY-MM-DD for backend
  function formatDate (date) {
    if (!date) return null
    if (typeof date === 'string' && /^\d{4}-\d{2}-\d{2}$/.test(date)) return date
    if (typeof date === 'string') {
      const ymdMatch = date.match(/^(\d{4})-(\d{2})-(\d{2})/)
      if (ymdMatch) return `${ymdMatch[1]}-${ymdMatch[2]}-${ymdMatch[3]}`
      const isoMatch = date.match(/^(\d{4})-(\d{2})-(\d{2})T/)
      if (isoMatch) return `${isoMatch[1]}-${isoMatch[2]}-${isoMatch[3]}`
    }
    const d = date instanceof Date ? date : new Date(date)
    if (isNaN(d.getTime())) return null
    const year = d.getFullYear()
    const month = String(d.getMonth() + 1).padStart(2, '0')
    const day = String(d.getDate()).padStart(2, '0')
    return `${year}-${month}-${day}`
  }

  // Watch for date input changes
  watch(dateInputValue, newValue => {
    if (isRangeMode.value) {
      // Range mode: newValue is an array
      if (Array.isArray(newValue)) {
        switch (newValue.length) {
          case 0: {
            startDateValue.value = null
            endDateValue.value = null

            break
          }
          case 1: {
            startDateValue.value = newValue[0]
            endDateValue.value = null

            break
          }
          case 2: {
            const sorted = [...newValue].sort((a, b) => {
              const dateA = a instanceof Date ? a.getTime() : new Date(a).getTime()
              const dateB = b instanceof Date ? b.getTime() : new Date(b).getTime()
              return dateA - dateB
            })
            startDateValue.value = sorted[0]
            endDateValue.value = sorted[1]

            break
          }
        // No default
        }
      }
    } else {
      // Single date mode: newValue is a single value
      const date = newValue || null
      if (singleDateType.value === 'start') {
        startDateValue.value = date
      } else {
        endDateValue.value = date
      }
    }
  })

  // Watch for mode changes and update dateInputValue accordingly
  watch([isRangeMode, singleDateType], () => {
    if (isRangeMode.value) {
      // Switch to range mode: ensure dateInputValue is an array
      if (startDateValue.value && endDateValue.value) {
        const start = startDateValue.value instanceof Date ? startDateValue.value : new Date(startDateValue.value)
        const end = endDateValue.value instanceof Date ? endDateValue.value : new Date(endDateValue.value)
        dateInputValue.value = start.getTime() <= end.getTime() ? [start, end] : [end, start]
      } else if (startDateValue.value) {
        dateInputValue.value = [startDateValue.value instanceof Date ? startDateValue.value : new Date(startDateValue.value)]
      } else {
        dateInputValue.value = []
      }
    } else {
      // Switch to single mode: ensure dateInputValue is a single value
      dateInputValue.value = singleDateType.value === 'start' ? startDateValue.value : endDateValue.value
    }
  }, { immediate: true })

  async function handleFindEvents () {
    await form.value.validate()
    if (!isFormValid.value) return

    const payload = {
      searchKeyword: findForm.searchKeyword,
      startDate: formatDate(startDateValue.value),
      endDate: formatDate(endDateValue.value),
      category: findForm.category,
      sort: findForm.sort,
    }

    emit('findEvents', payload)
  }

  function resetForm () {
    form.value.reset()
    startDateValue.value = null
    endDateValue.value = null
    dateInputValue.value = isRangeMode.value ? [] : null
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
                  v-model="dateInputValue"
                  class="mb-3 mb-md-0 mr-0 mr-md-2"
                  clearable
                  color="primary"
                  density="comfortable"
                  hide-details
                  :hide-header="false"
                  :label="isRangeMode ? 'Start & End Date' : (singleDateType === 'start' ? 'Start Date' : 'End Date')"
                  :multiple="isRangeMode ? 'range' : false"
                  prepend-icon=""
                  @click-clear="startDateValue = null; endDateValue = null"
                >
                  <template #header="{ header, transition }">
                    <div class="d-flex align-center justify-space-between pa-2 px-6">
                      <div class="d-flex align-center" style="gap: 8px; flex: 1;">
                        <span class="text-caption text-medium-emphasis">Range</span>
                        <v-switch
                          v-model="isRangeMode"
                          color="primary"
                          density="compact"
                          hide-details
                          size="x-small"
                        />
                      </div>
                      <div
                        v-if="!isRangeMode"
                        class="d-flex align-center"
                        style="gap: 8px; flex: 1;"
                      >
                        <span class="text-caption text-medium-emphasis">Type</span>
                        <v-btn-toggle
                          v-model="singleDateType"
                          color="primary"
                          density="compact"
                          mandatory
                          size="x-small"
                          variant="outlined"
                        >
                          <v-btn size="x-small" value="start">
                            Start
                          </v-btn>
                          <v-btn size="x-small" value="end">
                            End
                          </v-btn>
                        </v-btn-toggle>
                      </div>
                    </div>
                  </template>
                </v-date-input>
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
                  :ripple="false"
                  v-bind="props"
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
.event-form .mdi-close-circle {
  position: absolute;
  right: 2px;
}

.event-form .mdi-menu-down {
  position: absolute;
  right: 20px;
}
</style>
