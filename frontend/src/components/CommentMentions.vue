<script setup>
  import { computed } from 'vue'
  import { goUserProfile } from '@/others/util.js'

  const props = defineProps({
    text: {
      type: String,
      required: true,
    },
    mentions: {
      type: Array,
      default: () => [],
    },
  })

  // Parse text and replace mentions with clickable links
  const parsedText = computed(() => {
    if (!props.text || !props.mentions || props.mentions.length === 0) {
      return props.text
    }

    let result = props.text

    // Sort mentions by name length (longest first) to avoid partial matches
    const sortedMentions = [...props.mentions].sort((a, b) => {
      const nameA = (a.fullName || '').length
      const nameB = (b.fullName || '').length
      return nameB - nameA
    })

    // Replace each mention with clickable link
    for (const mention of sortedMentions) {
      const fullName = mention.fullName || ''
      if (!fullName) continue

      const escapedName = fullName.replace(/[.*+?^${}()|[\]\\]/g, String.raw`\$&`)
      // Match @name followed by space or end of string (mentions are stored with space after name)
      const regex = new RegExp(`@${escapedName}(?=\\s|$)`, 'gi')

      result = result.replace(regex, match => {
        const userId = mention.userId || mention.mentionedUserId
        const slug = mention.slug || userId
        if (!userId) return match

        return `<span class="mention-link" data-user-id="${userId}" data-slug="${slug}">${match}</span>`
      })
    }

    return result
  })

  function handleMentionClick (event) {
    const mentionElement = event.target.closest('.mention-link')
    if (mentionElement) {
      const slug = mentionElement.dataset.slug
      const userId = mentionElement.dataset.userId
      goUserProfile(slug || userId)
    }
  }
</script>

<template>
  <span
    class="comment-mentions"
    @click="handleMentionClick"
    v-html="parsedText"
  />
</template>

<style scoped>
.comment-mentions {
  white-space: pre-wrap;
  word-wrap: break-word;
}

.comment-mentions :deep(.mention-link) {
  color: #e40046;
  font-weight: 500;
  cursor: pointer;
  text-decoration: none;
}

.comment-mentions :deep(.mention-link:hover) {
  text-decoration: underline;
}
</style>
