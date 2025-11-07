import { ROLES } from '@/others/constants.js'
import { countries } from '@/others/country-list.js'
import router from '@/router/index.js'

export const appInfo = { name: 'WayzAway', version: 2.0 }

export const apiBaseUrl = import.meta.env.VITE_API_BASE_URL
export const baseUrl = import.meta.env.VITE_BASE_URL
export const isProd = import.meta.env.PROD

export function getCurrencySymbol ({ code, type }) {
  const codeLower = code.toString().toLowerCase()
  const currencyMap = {
    usd: { icon: 'mdi-currency-usd', symbol: '$', value: 'usd' },
    gbp: { icon: 'mdi-currency-gbp', symbol: '£', value: 'gbp' },
    eur: { icon: 'mdi-currency-eur', symbol: '€', value: 'eur' },
    thb: { icon: 'mdi-currency-thb', symbol: '฿', value: 'thb' },
  }
  const currencyData = currencyMap[codeLower]
  if (!currencyData) {
    return null // Or undefined, or throw an error, depending on your desired behavior
  }
  if (type === undefined) {
    return currencyData
  }
  return currencyData[type]
}

export function formatPrice (price, currency = 'GBP') {
  const symbol = getCurrencySymbol({ code: currency, type: 'symbol' })
  return `${symbol || currency}${price}`
}

export const ifAdmin = role => role === ROLES.ADMIN
export const ifCustomer = role => role === ROLES.CUSTOMER

export function to12hTime (time24) {
  let [h, m] = time24.split(':').map(Number)
  const period = h < 12 ? 'AM' : 'PM'
  h = (h % 12 || 12).toString().padStart(2, '0')
  m = m.toString().padStart(2, '0')
  return `${h}:${m} ${period}`
}

// get iso datetime offset with timezone
export function toLocalISOString (inputDate) {
  const date = new Date(inputDate)
  const tzoffset = date.getTimezoneOffset() * 60_000 // offset in milliseconds
  const localISOTime = new Date(date - tzoffset).toISOString().slice(0, -1)
  return localISOTime
}

export function formatDate (inputDate) {
  const date = new Date(inputDate)
  const day = `0${date.getDate()}`.slice(-2)
  const month = `0${date.getMonth() + 1}`.slice(-2)
  const year = date.getFullYear()
  return `${day}/${month}/${year}`
}

export function formatDateFromTimestamp (timestamp) {
  const date = new Date(timestamp)
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0') // Months are 0-indexed
  const day = String(date.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

// Calculate days until expiration
export function getDaysUntilExpiration (expiresAt) {
  if (!expiresAt) {
    return null
  }
  const now = new Date()
  const expires = new Date(expiresAt)
  const diffTime = expires - now
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
  return Math.max(diffDays, 0)
}

// Format expiration date
export function formatExpirationDate (expiresAt) {
  if (!expiresAt) {
    return null
  }
  return new Date(expiresAt).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  })
}

export function getCurrentDate () {
  const timestamp = new Date()
  return new Date(
    timestamp.getFullYear(),
    timestamp.getMonth(),
    timestamp.getDate(),
  )
}

export function isObjEmpty (obj) {
  return !obj || (Object.keys(obj).length === 0 && obj.constructor === Object)
}

export function formatTimeFromDate (currentDate) {
  return `${currentDate.getHours()}:${currentDate.getMinutes()}`
}

export function formatTimeFromTime (time) {
  return time?.slice(0, 5)
}

export function getDate (date) {
  const eventDate = new Date(date)
  return eventDate.getDate()
}

export function formatMonthYear (date) {
  const eventDate = new Date(date)
  const options = { year: 'numeric', month: 'long' }
  return eventDate.toLocaleDateString('en-US', options)
}

export function formatMonthDate (date) {
  const eventDate = new Date(date)
  const options = { day: 'numeric', month: 'long' }
  return eventDate.toLocaleDateString('en-US', options)
}

export function loadEventThumb (imageName, category) {
  return category?.toLowerCase() === 'registration'
    ? getClientPublicImgUrl('default-registration.jpeg')
    : getEventImageUrl(imageName || null)
}

export function getClientPublicImgUrl (imageName) {
  return imageName ? `/img/${imageName}` : null
}

export function getApiPublicImgUrl (imageName, type) {
  return `${apiBaseUrl}/${type}/${imageName}`
}

export function getEventImageUrl (imageName) {
  return imageName == null || !imageName
    ? getClientPublicImgUrl('default-event.jpg')
    : getApiPublicImgUrl(imageName, 'event')
}

export function getBlogImageUrl (imageName) {
  return imageName == null || !imageName
    ? getClientPublicImgUrl('default-blog.jpg')
    : getApiPublicImgUrl(imageName, 'blog')
}

export function getPageImageUrl (imageName) {
  return imageName == null || !imageName
    ? getClientPublicImgUrl('default-blog.jpg')
    : getApiPublicImgUrl(imageName, 'page')
}

export function getUserImageUrl (imageName) {
  return imageName === 'null' || !imageName
    ? getClientPublicImgUrl('default-user.jpg')
    : getApiPublicImgUrl(imageName, 'user')
}

export function getWishlistImageUrl (imageName) {
  return imageName == null || !imageName
    ? getClientPublicImgUrl('default-event.jpg')
    : getApiPublicImgUrl(imageName, 'wishlist')
}

export function goUserProfile (identifier) {
  // identifier can be either userId (number) or slug (string) or user object
  let slug = identifier

  // If identifier is an object (user), extract slug or id
  if (typeof identifier === 'object' && identifier !== null) {
    slug = identifier.slug || identifier.id
  }

  router.push({ name: 'wall', params: { id: slug } })
}

export function getToLink (item) {
  if (item.to.params) {
    const paramKey = Object.keys(item.to.params)[0]
    const paramVal = item.to.params[paramKey]
    return {
      name: item.to.name,
      params: { [paramKey]: paramVal },
    }
  }
  return item.to
}

export function getCountryList (filterName) {
  if (filterName === 'both') {
    return countries
  }
  return countries.map(item => item[filterName])
}

export function getQueryParam ({ url, param }) {
  const { searchParams } = url ? new URL(url) : new URL(window.location.href)
  return searchParams.get(param)
}

export function removeQueryParams ({ url, paramsToRemove }) {
  const urlObj = url ? new URL(url) : new URL(window.location.href)
  const { searchParams } = urlObj

  for (const param of paramsToRemove) {
    searchParams.delete(param)
  }
  urlObj.search = searchParams.toString()
  return urlObj.toString()
}

export function isValidEmail (emails) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (typeof emails === 'string') {
    emails = [emails]
  }
  return emails.every(email => emailRegex.test(email.trim()))
}

export function isValidImage (file) {
  if (!file) {
    return false
  }
  const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png']
  return allowedTypes.includes(file?.type)
}

export function isValidSlug (slug) {
  // Slug validation: only lowercase letters, numbers, and hyphens
  const slugRegex = /^[a-z0-9]+(?:-[a-z0-9]+)*$/
  return slugRegex.test(slug) && slug.length >= 3 && slug.length <= 50
}

export function generateSlugFromText (text) {
  if (!text) {
    return ''
  }

  return text
    .toString()
    .toLowerCase()
    .trim()
    .replace(/\s+/g, '-') // Replace spaces with hyphens
    .replace(/[^\w\s-]/g, '') // Remove special characters
    .replace(/-+/g, '-') // Replace multiple hyphens with single hyphen
    .replace(/^-+|-+$/g, '') // Remove leading/trailing hyphens
}

export const isValidPass = [
  v => !!v || 'Password is required!',
  v => v.length >= 8 || 'Password must be 8 or more characters!',
  v => /\d/.test(v) || 'Password must include at least one number!',
]

export function showApiQueryMsg () {
  if (localStorage.hasOwnProperty('apiQueryMsg')) {
    store.commit('addSnackbar', {
      text: localStorage.getItem('apiQueryMsg'),
    })
    localStorage.removeItem('apiQueryMsg')
  }
}

export function handleRedirect ({ param, hardRedirect = true }) {
  const paramValue = getQueryParam({ param })
  if (paramValue) {
    const newUrl = paramValue

    if (hardRedirect) {
      window.location.replace(newUrl)
    } else {
      window.history.replaceState({}, document.title, newUrl)
    } // Corrected: Use .replace() as a method
    return true // Indicates a redirect happened
  }
  return false
}

export function handleRemoveQueriesNRedirect ({
  params = [], // Array of param names to check/remove
  saveToLocalStorage = true,
  hardRedirect = true,
}) {
  let found = false
  const queryParamsToRemove = []

  for (const paramName of params) {
    const paramValue = getQueryParam({ param: paramName })

    if (paramValue) {
      found = true
      queryParamsToRemove.push(paramName)

      if (saveToLocalStorage) {
        localStorage.setItem(paramName, paramValue)
      }
    }
  }

  if (found) {
    const newUrl = removeQueryParams({ paramsToRemove: queryParamsToRemove })

    if (hardRedirect) {
      window.location.replace(newUrl)
    } else {
      window.history.replaceState({}, document.title, newUrl)
    }
    return true
  }
  return false
}
