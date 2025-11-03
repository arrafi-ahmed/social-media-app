# Vuetify Utility Classes Guide

## Common CSS Patterns → Vuetify Classes

### Flexbox Layout
```css
/* ❌ Custom CSS */
display: flex;
align-items: center;
justify-content: center;

/* ✅ Vuetify Classes */
class="d-flex align-center justify-center"
```

### Spacing
```css
/* ❌ Custom CSS */
margin-top: 16px;
margin-bottom: 16px;
padding: 16px;

/* ✅ Vuetify Classes */
class="mt-4 mb-4 pa-4"
```

### Text Alignment
```css
/* ❌ Custom CSS */
text-align: center;

/* ✅ Vuetify Classes */
class="text-center"
```

### Positioning
```css
/* ❌ Custom CSS */
position: absolute;
top: 8px;
right: 8px;

/* ✅ Vuetify Classes */
class="position-absolute"
/* Custom positioning still needs CSS for specific values */
```

### Cursor
```css
/* ❌ Custom CSS */
cursor: pointer;

/* ✅ Vuetify Classes */
class="clickable" (defined in App.vue)
```

## Complete Vuetify Utility Reference

### Display
- `d-flex` - display: flex
- `d-block` - display: block
- `d-inline` - display: inline
- `d-inline-block` - display: inline-block
- `d-none` - display: none

### Flexbox
- `flex-row` - flex-direction: row
- `flex-column` - flex-direction: column
- `flex-wrap` - flex-wrap: wrap
- `flex-nowrap` - flex-wrap: nowrap
- `align-start` - align-items: flex-start
- `align-center` - align-items: center
- `align-end` - align-items: flex-end
- `justify-start` - justify-content: flex-start
- `justify-center` - justify-content: center
- `justify-end` - justify-content: flex-end
- `justify-space-between` - justify-content: space-between
- `justify-space-around` - justify-content: space-around

### Spacing (margin/padding)
- `ma-0` to `ma-16` - margin: 0 to 64px
- `mt-0` to `mt-16` - margin-top
- `mb-0` to `mb-16` - margin-bottom
- `ml-0` to `ml-16` - margin-left
- `mr-0` to `mr-16` - margin-right
- `mx-0` to `mx-16` - margin-left and margin-right
- `my-0` to `my-16` - margin-top and margin-bottom
- `pa-0` to `pa-16` - padding: 0 to 64px
- `pt-0` to `pt-16` - padding-top
- `pb-0` to `pb-16` - padding-bottom
- `pl-0` to `pl-16` - padding-left
- `pr-0` to `pr-16` - padding-right
- `px-0` to `px-16` - padding-left and padding-right
- `py-0` to `py-16` - padding-top and padding-bottom

### Text
- `text-left` - text-align: left
- `text-center` - text-align: center
- `text-right` - text-align: right
- `text-uppercase` - text-transform: uppercase
- `text-lowercase` - text-transform: lowercase
- `text-capitalize` - text-transform: capitalize
- `font-weight-thin` - font-weight: 100
- `font-weight-light` - font-weight: 300
- `font-weight-regular` - font-weight: 400
- `font-weight-medium` - font-weight: 500
- `font-weight-bold` - font-weight: 700
- `font-weight-black` - font-weight: 900

### Positioning
- `position-relative` - position: relative
- `position-absolute` - position: absolute
- `position-fixed` - position: fixed
- `position-sticky` - position: sticky

### Colors
- `text-primary` - primary color
- `text-secondary` - secondary color
- `text-success` - success color
- `text-error` - error color
- `text-warning` - warning color
- `text-info` - info color
- `bg-primary` - background primary color
- `bg-secondary` - background secondary color
- etc.

### Borders
- `rounded` - border-radius: 4px
- `rounded-lg` - border-radius: 8px
- `rounded-xl` - border-radius: 12px
- `rounded-0` - border-radius: 0
- `rounded-circle` - border-radius: 50%

### Elevation/Shadows
- `elevation-0` to `elevation-24` - box-shadow levels

## Best Practices

1. **Use Vuetify utilities first** - Always check if Vuetify has a utility class before writing custom CSS
2. **Combine classes** - You can combine multiple utility classes: `class="d-flex align-center justify-center pa-4"`
3. **Responsive utilities** - Add breakpoint prefixes: `class="d-none d-md-flex"` (hidden on mobile, flex on medium+)
4. **Custom CSS only when needed** - Only write custom CSS for things Vuetify doesn't provide
5. **Global utilities in App.vue** - Put reusable custom utilities in App.vue, not individual components

## Responsive Breakpoints
- `xs` - 0px+
- `sm` - 600px+
- `md` - 960px+
- `lg` - 1264px+
- `xl` - 1904px+

Example: `class="d-none d-md-flex"` - hidden on mobile, flex on medium screens and up
