import $axios from '@/plugins/axios'

export function parseStoredInvite () {
  const storedInvite = localStorage.getItem('acceptInvite')
  if (!storedInvite) {
    return null
  }

  try {
    return JSON.parse(storedInvite)
  } catch {
    localStorage.removeItem('acceptInvite')
    return null
  }
}

export async function handleInviteAfterAuth (currentUser = {}) {
  const inviteData = parseStoredInvite()
  if (!inviteData?.token) {
    return false
  }

  const currentEmail = currentUser?.email?.toLowerCase?.()
  if (inviteData.email && currentEmail && inviteData.email.toLowerCase() !== currentEmail) {
    localStorage.setItem('apiQueryMsg', 'Invitation email does not match the registered account.')
    localStorage.removeItem('acceptInvite')
    return false
  }

  try {
    const response = await $axios.post('/user/acceptInvite', { token: inviteData.token })
    const successMessage = response?.data?.message || 'Friend invitation accepted!'
    localStorage.setItem('apiQueryMsg', successMessage)
  } catch (error) {
    const message = error?.response?.data?.message || 'Invitation accepting failed!'
    localStorage.setItem('apiQueryMsg', message)
  } finally {
    localStorage.removeItem('acceptInvite')
  }

  return true
}

