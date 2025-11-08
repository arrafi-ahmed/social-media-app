<script setup>
  import { computed, reactive, ref } from 'vue'
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
      // Debug: log what Vuetify is returning
      console.log('findForm.dates (raw):', findForm.dates)
      console.log('findForm.dates types:', findForm.dates.map(d => ({ value: d, type: typeof d, isDate: d instanceof Date })))
      
      // Sort dates properly - convert to comparable format first
      const sorted = [...findForm.dates].sort((a, b) => {
        const dateA = a instanceof Date ? a.getTime() : (typeof a === 'string' ? new Date(a).getTime() : 0)
        const dateB = b instanceof Date ? b.getTime() : (typeof b === 'string' ? new Date(b).getTime() : 0)
        return dateA - dateB
      })
      
      console.log('sorted dates:', sorted)
      
      // Format dates to YYYY-MM-DD for backend
      const formatDate = (date) => {
        if (!date) return null
        
        // If already in YYYY-MM-DD format, return as is
        if (typeof date === 'string' && /^\d{4}-\d{2}-\d{2}$/.test(date)) {
          return date
        }
        
        // If it's a string, try to extract date components directly
        if (typeof date === 'string') {
          // Try to match YYYY-MM-DD format (with or without time)
          const ymdMatch = date.match(/^(\d{4})-(\d{2})-(\d{2})/)
          if (ymdMatch) {
            return `${ymdMatch[1]}-${ymdMatch[2]}-${ymdMatch[3]}`
          }
          // Try to match ISO format with time (YYYY-MM-DDTHH:mm:ss)
          const isoMatch = date.match(/^(\d{4})-(\d{2})-(\d{2})T/)
          if (isoMatch) {
            return `${isoMatch[1]}-${isoMatch[2]}-${isoMatch[3]}`
          }
          // Try to match other common formats
          const dateMatch = date.match(/(\d{4})[\/-](\d{1,2})[\/-](\d{1,2})/)
          if (dateMatch) {
            const year = dateMatch[1]
            const month = String(dateMatch[2]).padStart(2, '0')
            const day = String(dateMatch[3]).padStart(2, '0')
            return `${year}-${month}-${day}`
          }
        }
        
        // Convert Date object to YYYY-MM-DD
        // For Date objects, we need to handle timezone carefully
        const d = date instanceof Date ? date : new Date(date)
        if (isNaN(d.getTime())) return null // Invalid date
        
        // For Date objects, use local time methods since date pickers typically work in local time
        // This ensures the date shown in the picker matches the date sent to the backend
        const year = d.getFullYear()
        const month = String(d.getMonth() + 1).padStart(2, '0')
        const day = String(d.getDate()).padStart(2, '0')
        return `${year}-${month}-${day}`
      }
      startDate = formatDate(sorted[0])
      endDate = formatDate(sorted.at(-1))
      
      console.log('Formatted startDate:', startDate)
      console.log('Formatted endDate:', endDate)
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
