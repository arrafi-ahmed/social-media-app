// Composables
import { createVuetify } from 'vuetify'

/**
 * plugins/vuetify.js
 *
 * Framework documentation: https://vuetifyjs.com`
 */
// lab
import { VDateInput } from 'vuetify/labs/VDateInput'
import { VFileUpload } from 'vuetify/labs/VFileUpload'

// Styles
import '@mdi/font/css/materialdesignicons.css'

import 'vuetify/styles'

const dark = {
  dark: true,
  colors: {
    'header': '#2A3A47',
    'background': '#2A3A47',
    'surface': '#3b4d59',
    'primary': '#58a6ff',
    'secondary': '#00bfa5',
    'success': '#4CAF50',
    'error': '#EF5350',
    'on-background': '#E8EFF5',
    'on-surface': '#E8EFF5',
  },
}
const light = {
  dark: false,
  colors: {
    'header': '#ffffff', // clean white header
    'background': '#f9f9fb', // light neutral page background
    'surface': '#ffffff', // cards/panels stay white
    'primary': '#e40046', // your brand red, unchanged
    'secondary': '#595959', // neutral gray for secondary UI
    'success': '#4CAF50', // standard green
    'error': '#EF5350', // standard red
    'on-background': '#1a1a1a', // dark text on light background
    'on-surface': '#1a1a1a', // dark text on cards/surfaces
  },
}

// Get initial theme from localStorage
const getStoredTheme = () => {
  try {
    const storedUser = JSON.parse(localStorage.getItem('currentUser') || '{}')
    return storedUser.theme || 'light'
  } catch {
    return 'light'
  }
}

// https://vuetifyjs.com/en/introduction/why-vuetify/#feature-guides
export default createVuetify({
  components: {
    VFileUpload,
    VDateInput,
  },
  theme: {
    defaultTheme: getStoredTheme(),
    themes: {
      dark,
      light,
    },
  },
  defaults: {
    VTextField: {
      variant: 'solo',
    },
    VSelect: {
      variant: 'solo',
    },
    VDateInput: {
      variant: 'solo',
    },
    global: {
      fontFamily: 'Oxygen, sans-serif',
    },
  },
})
