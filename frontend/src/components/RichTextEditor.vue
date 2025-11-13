<template>
  <div class="rich-text-editor">
    <!-- Toolbar -->
    <v-card class="mb-2" elevation="1">
      <v-card-text class="py-3 px-4 d-flex flex-wrap align-center toolbar-container">
        <!-- Text Formatting -->
        <div class="d-flex button-group">
          <v-btn
            class="toolbar-button"
            :class="{ 'v-btn--active': isEditorActive('bold') }"
            icon="mdi-format-bold"
            rounded="sm"
            size="small"
            variant="outlined"
            @click="toggleBold"
          />
          <v-btn
            class="toolbar-button"
            :class="{ 'v-btn--active': isEditorActive('italic') }"
            icon="mdi-format-italic"
            rounded="sm"
            size="small"
            variant="outlined"
            @click="toggleItalic"
          />
          <v-btn
            class="toolbar-button"
            :class="{ 'v-btn--active': isEditorActive('underline') }"
            icon="mdi-format-underline"
            rounded="sm"
            size="small"
            variant="outlined"
            @click="toggleUnderline"
          />
        </div>

        <v-divider class="toolbar-divider" vertical />

        <!-- Headings -->
        <v-menu>
          <template #activator="{ props }">
            <v-btn
              class="toolbar-button"
              rounded="sm"
              size="small"
              v-bind="props"
              variant="outlined"
            >
              <v-icon start>mdi-format-header-1</v-icon>
              <v-icon end>mdi-chevron-down</v-icon>
            </v-btn>
          </template>
          <v-list>
            <v-list-item
              v-for="level in [1, 2, 3]"
              :key="level"
              :active="isEditorActive('heading', { level })"
              @click="toggleHeading(level)"
            >
              <v-list-item-title>Heading {{ level }}</v-list-item-title>
            </v-list-item>
            <v-list-item
              :active="isEditorActive('paragraph')"
              @click="setParagraph"
            >
              <v-list-item-title>Paragraph</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>

        <v-divider class="toolbar-divider" vertical />

        <!-- Lists -->
        <div class="d-flex button-group">
          <v-btn
            class="toolbar-button"
            :class="{ 'v-btn--active': isEditorActive('bulletList') }"
            icon="mdi-format-list-bulleted"
            rounded="sm"
            size="small"
            variant="outlined"
            @click="toggleBulletList"
          />
          <v-btn
            class="toolbar-button"
            :class="{ 'v-btn--active': isEditorActive('orderedList') }"
            icon="mdi-format-list-numbered"
            rounded="sm"
            size="small"
            variant="outlined"
            @click="toggleOrderedList"
          />
        </div>

        <v-divider class="toolbar-divider" vertical />

        <!-- Link -->
        <v-btn
          class="toolbar-button"
          :class="{ 'v-btn--active': isEditorActive('link') }"
          icon="mdi-link"
          rounded="sm"
          size="small"
          variant="outlined"
          @click="setLink"
        />
      </v-card-text>
    </v-card>

    <!-- Editor Content Area -->
    <v-card v-if="editor" :class="{ 'editor-focused': isFocused }" elevation="1">
      <editor-content class="editor-content" :editor="editor" />
    </v-card>
    <v-card v-else elevation="1">
      <v-card-text class="text-center py-8">
        <v-progress-circular color="primary" indeterminate />
      </v-card-text>
    </v-card>

    <!-- Link Dialog -->
    <v-dialog v-model="linkDialog" max-width="500">
      <v-card>
        <v-card-title>Add Link</v-card-title>
        <v-card-text>
          <v-text-field
            v-model="linkUrl"
            label="URL"
            placeholder="https://example.com"
            variant="solo"
          />
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn variant="text" @click="linkDialog = false">Cancel</v-btn>
          <v-btn color="primary" variant="text" @click="confirmLink">Confirm</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script setup>
  import Link from '@tiptap/extension-link'
  import Underline from '@tiptap/extension-underline'
  import StarterKit from '@tiptap/starter-kit'
  import { EditorContent, useEditor } from '@tiptap/vue-3'
  import { nextTick, onBeforeUnmount, ref, watch } from 'vue'

  const props = defineProps({
    modelValue: {
      type: String,
      default: '',
    },
    placeholder: {
      type: String,
      default: 'Start typing...',
    },
  })

  const emit = defineEmits(['update:modelValue'])

  const isFocused = ref(false)
  const linkDialog = ref(false)
  const linkUrl = ref('')
  const editorReady = ref(false)

  // Helper function to convert plain text with line breaks to HTML paragraphs
  function convertTextToHtml (text) {
    if (!text) return ''
    // If it's already HTML (contains tags), return as is
    if (/<[a-z][\s\S]*>/i.test(text)) {
      return text
    }
    // Convert plain text with line breaks to HTML paragraphs
    return text
      .split(/\n\n+/) // Split on double line breaks (paragraphs)
      .map(para => para.trim())
      .filter(para => para.length > 0)
      .map(para => `<p>${para.replace(/\n/g, '<br>')}</p>`)
      .join('')
  }

  // Initialize editor using useEditor composable
  const editor = useEditor({
    content: convertTextToHtml(props.modelValue || ''),
    extensions: [
      StarterKit.configure({
        heading: {
          levels: [1, 2, 3],
        },
        // Ensure paragraphs are preserved
        paragraph: {
          HTMLAttributes: {
            class: 'editor-paragraph',
          },
        },
      }),
      Underline,
      Link.configure({
        openOnClick: false,
        HTMLAttributes: {
          target: '_blank',
          rel: 'noopener noreferrer',
        },
      }),
    ],
    editorProps: {
      attributes: {
        'class': 'prose prose-sm sm:prose lg:prose-lg xl:prose-2xl mx-auto focus:outline-none min-h-[300px] p-4',
        'data-placeholder': props.placeholder,
        'spellcheck': 'false',
      },
    },
    onUpdate: ({ editor }) => {
      emit('update:modelValue', editor.getHTML())
    },
    onFocus: () => {
      isFocused.value = true
    },
    onBlur: () => {
      isFocused.value = false
    },
    onCreate: () => {
      editorReady.value = true
    },
  })

  // Wait for editor to be fully ready
  watch(() => editor.value, async newEditor => {
    if (newEditor && !editorReady.value) {
      await nextTick()
      editorReady.value = true
    }
  }, { immediate: true })

  // Safe wrapper for isActive checks
  function isEditorActive (name, options = {}) {
    if (!editor.value || !editorReady.value || typeof editor.value.isActive !== 'function') {
      return false
    }
    try {
      return editor.value.isActive(name, options)
    } catch {
      return false
    }
  }

  // Helper to check if editor is ready with chain method
  function isEditorReady () {
    return editor.value && editorReady.value && typeof editor.value.chain === 'function'
  }

  // Wrapper functions for editor commands
  function toggleBold () {
    if (isEditorReady()) {
      editor.value.chain().focus().toggleBold().run()
    }
  }

  function toggleItalic () {
    if (isEditorReady()) {
      editor.value.chain().focus().toggleItalic().run()
    }
  }

  function toggleUnderline () {
    if (isEditorReady()) {
      editor.value.chain().focus().toggleUnderline().run()
    }
  }

  function toggleHeading (level) {
    if (isEditorReady()) {
      editor.value.chain().focus().toggleHeading({ level }).run()
    }
  }

  function setParagraph () {
    if (isEditorReady()) {
      editor.value.chain().focus().setParagraph().run()
    }
  }

  function toggleBulletList () {
    if (isEditorReady()) {
      editor.value.chain().focus().toggleBulletList().run()
    }
  }

  function toggleOrderedList () {
    if (isEditorReady()) {
      editor.value.chain().focus().toggleOrderedList().run()
    }
  }

  function setLink () {
    if (!isEditorReady() || typeof editor.value.isActive !== 'function') return

    try {
      if (editor.value.isActive('link')) {
        editor.value.chain().focus().extendMarkRange('link').unsetLink().run()
      } else {
        const url = window.getSelection().toString() || ''
        linkUrl.value = url
        linkDialog.value = true
      }
    } catch (error) {
      console.error('Error setting link:', error)
    }
  }

  function confirmLink () {
    if (linkUrl.value && isEditorReady()) {
      editor.value.chain().focus().setLink({ href: linkUrl.value }).run()
    }
    linkDialog.value = false
    linkUrl.value = ''
  }

  // Watch for external changes to modelValue
  watch(() => props.modelValue, async newValue => {
    // Wait for editor to be ready if it's not yet
    if (!editor.value || !editorReady.value) {
      // Wait a bit and try again
      await nextTick()
      // If still not ready, wait a bit more
      if (!editor.value || !editorReady.value) {
        await new Promise(resolve => setTimeout(resolve, 100))
      }
    }

    if (editor.value && editorReady.value && editor.value.commands) {
      await nextTick()
      try {
        const currentHtml = editor.value.getHTML()
        const convertedNew = convertTextToHtml(newValue || '')
        const normalizedCurrent = currentHtml.replace(/\s+/g, ' ').trim()
        const normalizedNew = convertedNew.replace(/\s+/g, ' ').trim()
        // Only update if the content is actually different to avoid infinite loops
        if (normalizedCurrent !== normalizedNew) {
          editor.value.commands.setContent(convertedNew || '', false)
        }
      } catch (error) {
        console.error('Error updating editor content:', error)
      }
    }
  }, { immediate: false })

  onBeforeUnmount(() => {
    if (editor.value && editor.value.destroy) {
      editor.value.destroy()
    }
  })
</script>

<style scoped>
.rich-text-editor {
  width: 100%;
}

.toolbar-container {
  gap: 8px;
}

.button-group {
  gap: 4px;
}

.toolbar-button {
  margin: 0 !important;
}

.toolbar-divider {
  margin: 0 4px !important;
  opacity: 0.3;
}

.editor-content {
  min-height: 300px;
}

.editor-content :deep(.ProseMirror) {
  outline: none;
  min-height: 300px;
  padding: 16px;
  cursor: text;
}

.editor-content :deep(.ProseMirror:focus) {
  outline: none;
}

.editor-content :deep(.ProseMirror p) {
  min-height: 1.5em;
  margin: 0 0 0.75em 0;
}

.editor-content :deep(.ProseMirror p:last-child) {
  margin-bottom: 0;
}

.editor-content :deep(.ProseMirror p.is-editor-empty:first-child::before) {
  color: #adb5bd;
  content: attr(data-placeholder);
  float: left;
  height: 0;
  pointer-events: none;
  position: absolute;
}

.editor-content :deep(.ProseMirror h1),
.editor-content :deep(.ProseMirror h2),
.editor-content :deep(.ProseMirror h3) {
  font-weight: 600;
  line-height: 1.2;
  margin-top: 1em;
  margin-bottom: 0.5em;
}

.editor-content :deep(.ProseMirror h1) {
  font-size: 2em;
}

.editor-content :deep(.ProseMirror h2) {
  font-size: 1.5em;
}

.editor-content :deep(.ProseMirror h3) {
  font-size: 1.25em;
}

.editor-content :deep(.ProseMirror ul),
.editor-content :deep(.ProseMirror ol) {
  padding-left: 1.5em;
  margin-bottom: 0.75em;
}

.editor-content :deep(.ProseMirror ul) {
  list-style-type: disc;
}

.editor-content :deep(.ProseMirror ol) {
  list-style-type: decimal;
}

.editor-content :deep(.ProseMirror li) {
  margin-bottom: 0.25em;
}

.editor-content :deep(.ProseMirror a) {
  color: rgb(var(--v-theme-primary));
  text-decoration: underline;
}

.editor-content :deep(.ProseMirror a:hover) {
  opacity: 0.8;
}

.editor-focused :deep(.v-card) {
  border-color: rgb(var(--v-theme-primary));
}

:deep(.v-btn--active) {
  background-color: rgba(var(--v-theme-primary), 0.1);
}
</style>
