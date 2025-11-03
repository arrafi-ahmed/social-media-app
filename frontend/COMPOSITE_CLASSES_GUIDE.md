# Composite SCSS Classes Guide

## How It Works

You can create composite classes in SCSS that combine multiple Vuetify utility classes using `@extend`:

```scss
.container-border {
  @extend .rounded, .border, .pa-4, .mt-2, .mt-md-4;
}
```

This creates a single class that applies all the Vuetify utilities at once.

## Available Composite Classes

### Layout & Containers
```scss
.container-border    // rounded + border + pa-4 + mt-2 + mt-md-4
.card-container      // rounded-lg + pa-6 + ma-2 + elevation-2 + surface bg
.content-section     // pa-4 + mb-4 + rounded-lg + surface bg
.image-container     // rounded-lg + overflow-hidden + position-relative
```

### Flexbox Patterns
```scss
.flex-center         // d-flex + align-center + justify-center
.flex-between        // d-flex + align-center + justify-space-between
.button-group        // d-flex + gap-2 + align-center
.page-header         // d-flex + align-center + justify-space-between + mb-4 + pa-4
.action-bar          // d-flex + justify-end + gap-2 + pa-3 + bg-grey-lighten-5
```

### Form & UI Elements
```scss
.form-field-container // mb-4 + pa-2
.list-item           // d-flex + align-center + pa-3 + mb-2 + rounded + hover effect
.status-badge        // rounded-pill + px-3 + py-1 + text-caption + font-weight-medium
.text-section        // pa-4 + text-body-1 + line-height-normal
```

### Modal Components
```scss
.modal-header        // d-flex + align-center + justify-space-between + pa-4 + border-b
.modal-footer         // d-flex + justify-end + gap-2 + pa-4 + border-t
```

## Usage Examples

### Before (Multiple Classes)
```vue
<!-- ❌ Verbose -->
<div class="rounded border pa-4 mt-2 mt-md-4">
  <div class="d-flex align-center justify-space-between mb-4 pa-4">
    <h2>Title</h2>
    <button class="d-flex gap-2 align-center">Action</button>
  </div>
</div>
```

### After (Composite Classes)
```vue
<!-- ✅ Clean -->
<div class="container-border">
  <div class="page-header">
    <h2>Title</h2>
    <div class="button-group">
      <v-btn>Action</v-btn>
    </div>
  </div>
</div>
```

### Real Component Examples

#### Card Component
```vue
<template>
  <div class="card-container">
    <div class="page-header">
      <h3>{{ title }}</h3>
      <div class="button-group">
        <v-btn size="small">Edit</v-btn>
        <v-btn size="small" color="error">Delete</v-btn>
      </div>
    </div>
    
    <div class="content-section">
      <p>{{ description }}</p>
    </div>
    
    <div class="action-bar">
      <v-btn color="primary">Save</v-btn>
    </div>
  </div>
</template>
```

#### List Component
```vue
<template>
  <div class="container-border">
    <div v-for="item in items" :key="item.id" class="list-item">
      <div class="flex-between">
        <span>{{ item.name }}</span>
        <div class="button-group">
          <v-chip class="status-badge" :color="item.status === 'active' ? 'success' : 'warning'">
            {{ item.status }}
          </v-chip>
          <v-btn size="small" icon="mdi-edit"></v-btn>
        </div>
      </div>
    </div>
  </div>
</template>
```

#### Form Component
```vue
<template>
  <div class="card-container">
    <div class="page-header">
      <h2>User Settings</h2>
    </div>
    
    <div class="content-section">
      <div class="form-field-container">
        <v-text-field label="Name" v-model="name"></v-text-field>
      </div>
      
      <div class="form-field-container">
        <v-text-field label="Email" v-model="email"></v-text-field>
      </div>
    </div>
    
    <div class="modal-footer">
      <v-btn variant="outlined">Cancel</v-btn>
      <v-btn color="primary">Save Changes</v-btn>
    </div>
  </div>
</template>
```

## Benefits

✅ **Cleaner Templates**: Less verbose class lists  
✅ **Consistent Design**: Standardized component patterns  
✅ **Easy Maintenance**: Update patterns in one place  
✅ **Better Readability**: Semantic class names  
✅ **Reusable Patterns**: Common UI patterns as single classes  

## Creating Your Own Composite Classes

Add new patterns to `settings.scss`:

```scss
// Custom composite class
.my-custom-pattern {
  @extend .d-flex, .align-center, .pa-4, .rounded-lg;
  background-color: rgb(var(--v-theme-primary));
  color: rgb(var(--v-theme-on-primary));
}
```

## Best Practices

1. **Use semantic names**: `page-header` instead of `flex-between-pa4`
2. **Group related utilities**: Don't mix unrelated styles
3. **Add custom properties**: Use CSS custom properties for theme colors
4. **Keep it focused**: Each composite class should have a single purpose
5. **Document patterns**: Add comments explaining the purpose

## Advanced Patterns

### With Custom Properties
```scss
.themed-container {
  @extend .rounded-lg, .pa-4;
  background-color: rgb(var(--v-theme-surface));
  border: 1px solid rgb(var(--v-theme-outline));
  
  &:hover {
    background-color: rgb(var(--v-theme-surface-variant));
  }
}
```

### With Responsive Design
```scss
.responsive-grid {
  @extend .d-flex, .flex-wrap, .gap-4;
  
  @media (max-width: 600px) {
    flex-direction: column;
  }
}
```

