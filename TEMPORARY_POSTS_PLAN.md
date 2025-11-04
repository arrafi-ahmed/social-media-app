# Temporary Posts (Auto-delete after X days) - Implementation Plan

## Overview
Add option for users to set an expiration date for their posts (e.g., "delete in 30 days"). This keeps journals clutter-free by automatically removing temporary content.

## Database Changes

### 1. Migration File
**File:** `backend/migrations/add-expires-at-column.sql`

```sql
ALTER TABLE event_post 
ADD COLUMN expires_at TIMESTAMP NULL;

-- Add index for efficient deletion queries
CREATE INDEX idx_event_post_expires_at ON event_post(expires_at) WHERE expires_at IS NOT NULL;
```

**Changes:**
- Add `expires_at` column (nullable - NULL means permanent post)
- Add index for efficient scheduled deletion queries

## Backend Changes

### 2. Service Layer (`backend/src/service/event.js`)

**Changes to `save` function:**
- Accept `expiresAt` or `autoDeleteDays` from request body
- Calculate `expires_at` timestamp if provided
- Add `expires_at` to INSERT query

**Changes to `edit` function:**
- Accept `expiresAt` or `autoDeleteDays` from request body
- Update `expires_at` in UPDATE query
- Allow setting to NULL to make permanent

**New function: `deleteExpiredEvents`**
- Query all events where `expires_at IS NOT NULL AND expires_at <= NOW()`
- Delete associated images from filesystem
- Delete event records from database
- Return count of deleted events

**Query modifications:**
- Optionally filter out expired events in `getEventsByUserId`, `findBrowseEvents`, etc.
- OR keep them visible but add an indicator (recommended - let users see until deletion)

### 3. Scheduler (`backend/src/others/scheduler.js`)

**Add new scheduled task:**
- Run daily (same time as other tasks: `0 0 * * *`)
- Call `eventService.deleteExpiredEvents()`
- Log deletion count

**Example:**
```javascript
cron.schedule("0 0 * * *", async () => {
  const deletedCount = await eventService.deleteExpiredEvents();
  console.log(`Deleted ${deletedCount} expired events`);
});
```

### 4. Controller (`backend/src/controller/event.js`)

**No changes needed** - service layer handles the logic

## Frontend Changes

### 5. Event Model (`frontend/src/models/event.js`)

**Add properties:**
- `expiresAt = null` (timestamp)
- `autoDeleteDays = null` (number of days)

### 6. Event Add Page (`frontend/src/pages/event/add.vue`)

**Add UI section:**
- Toggle switch: "Make this post temporary"
- When enabled:
  - Show dropdown/input for days (7, 14, 30, 60, 90, custom)
  - Or date picker for exact expiration date
  - Display calculated expiration date
- Default: OFF (permanent post)

**Form submission:**
- Calculate `expiresAt` from `autoDeleteDays` if provided
- Send to backend in FormData

### 7. Event Edit Page (`frontend/src/pages/event/[id]/edit.vue`)

**Add same UI as Add page:**
- Pre-populate with existing `expiresAt` if set
- Show current expiration date if exists
- Allow removing expiration (set to permanent)

### 8. Event Card Component (`frontend/src/components/EventCard.vue`)

**Visual indicator:**
- Add badge/chip if `expiresAt` exists
- Show "Expires in X days" or "Expires on [date]"
- Use warning/orange color to indicate temporary status

### 9. Event Details Page (`frontend/src/pages/event/[id]/index.vue`)

**Show expiration info:**
- Add expiration badge in metadata section
- Display "This post will be automatically deleted on [date]"
- Style distinctly to grab attention

### 10. Store Updates (if needed)

**Check if store needs updates:**
- Event model already handles properties
- May need to update store actions to pass `expiresAt` through

## Implementation Approach

### Option A: Days-based (Recommended)
- User selects number of days (7, 14, 30, 60, 90, custom)
- Backend calculates: `expires_at = created_at + X days`
- Simpler UX, clear intent

### Option B: Date-based
- User selects exact expiration date
- More flexible but requires date picker
- Better for specific deadlines

### Recommended: Hybrid
- Default: Days selector (7, 14, 30, 60, 90, custom)
- Advanced option: Switch to date picker for exact date
- Best of both worlds

## UI/UX Details

### Event Add/Edit Form
```
[Toggle] Make this post temporary

[When enabled]
  Delete after: [Dropdown: 7 days | 14 days | 30 days | 60 days | 90 days | Custom]
  [If Custom selected] [Number input] days
  [Display] Expires on: [calculated date]
```

### Event Card Display
```
[Event Card]
  [Temporary Badge] "Expires in 5 days" (orange/warning color)
  ...rest of card
```

### Event Details Display
```
[Metadata Card]
  Date: ...
  Time: ...
  Location: ...
  [Warning Chip] ⚠️ Auto-deletes on [date]
```

## Edge Cases to Handle

1. **Editing existing temporary post:**
   - Allow changing expiration date
   - Allow removing expiration (make permanent)

2. **Expired events:**
   - Hide from listings OR show with "Expired" badge (recommend hiding)
   - Don't allow interactions (comments, favorites)

3. **Featured events:**
   - If temporary event is featured, unfeature when expired
   - Or prevent featuring temporary events

4. **Notifications:**
   - Don't send notifications for expired events

5. **Wishlist/Favorites:**
   - Handle deletion of favorited/wishlisted temporary events gracefully

## Security Considerations

1. **Validation:**
   - Max expiration days (e.g., 365 days)
   - Min expiration days (e.g., 1 day)
   - Ensure `expires_at` is in the future

2. **Permissions:**
   - Only event owner can set expiration
   - Admins can override/manage

## Files to Create/Modify

### Backend:
1. `backend/migrations/add-expires-at-column.sql` (NEW)
2. `backend/src/service/event.js` (MODIFY)
3. `backend/src/others/scheduler.js` (MODIFY)

### Frontend:
4. `frontend/src/models/event.js` (MODIFY)
5. `frontend/src/pages/event/add.vue` (MODIFY)
6. `frontend/src/pages/event/[id]/edit.vue` (MODIFY)
7. `frontend/src/components/EventCard.vue` (MODIFY)
8. `frontend/src/pages/event/[id]/index.vue` (MODIFY)
9. `frontend/src/store/modules/event-*.js` (MODIFY if needed)

## Testing Considerations

1. **Test expiration calculation:**
   - Verify correct date calculation for different day values
   - Test timezone handling

2. **Test scheduled deletion:**
   - Create test events with past expiration dates
   - Run scheduler manually or test deletion function

3. **Test UI:**
   - Toggle on/off works
   - Date calculation displays correctly
   - Badges show/hide appropriately

4. **Test edge cases:**
   - Editing expiration date
   - Removing expiration
   - Expired events don't appear in listings

## Implementation Priority

1. **Phase 1: Database & Backend Core**
   - Migration
   - Service layer updates
   - Scheduler task

2. **Phase 2: Frontend Forms**
   - Add/Edit form UI
   - Model updates
   - Form submission

3. **Phase 3: Visual Indicators**
   - Event card badges
   - Event details display
   - Store updates if needed

## Notes

- Use consistent date/time handling (UTC)
- Consider adding a "days remaining" calculation utility
- Make sure image deletion works correctly when events expire
- Consider user notification before deletion (optional enhancement)

