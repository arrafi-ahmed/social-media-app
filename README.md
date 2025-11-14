# WayzAway
## Features 
1. User Registration and Login:
- Secure and user-friendly registration and login processes.
- Users can create an account using their full name, email address, password, date of birth, and country.

2. User Profiles:
- Personalized user profiles featuring profile pictures, full names, countries of residence, and date of birth.
- Users can edit and update their profile information.

3. Your Wall (Home Page):
- A user's personalized home page displaying a chronological feed of event posts.
- Users can create new event posts directly from this page.

4. Favourites Page:
- A collection of event posts marked as favorites by the user.
- Users can easily view and remove posts from their favorites list.

5. Wishlist Page:
- A dedicated space for creating and managing a list of desired events.
- Users can add new events to their wishlist.

6. Browse Page:
- Allows users to discover event posts shared by their friends.
- Event posts are categorized and sorted chronologically.

7. Individual Post Page:
- Detailed view of a single event post.
- Users can comment on posts, express appreciation, and view event details.

8. Friends List Page:
- Users can manage their list of friends.
- Invite friends using email addresses.
- Unregistered friends are directed to the registration page.

9. Settings Page:
- User-specific options for customization and account management.
- Users can edit profile information, change email, password, and upload profile pictures.

10. Admin Blog Page (Admin-only):
- Exclusively for site administrators to create and manage blog content.

11. Admin Back Panel (Admin-only):
- Administrative control center for site management.
- Functions include event and user management, blog content, and more.

12. Dynamic Menu:
- Users can access key features via a menu icon next to their profile picture.

13. User-Friendly Landing Page:
- Clean and minimalistic landing page for user convenience.
- Quick access to the registration page for new users.

14. Event Categories:
- Event posts are categorized, making it easier to sort and filter events.

15. Event Image Handling:
- Event posts include images, and users can upload event cover pictures.

16. Event Date and Time:
- Users can specify the date and time of their events.

17. User Comments:
- Users can leave comments on event posts, facilitating interaction.

18. Invitations:
- Users can invite friends by providing email addresses and personalized messages.

19. Admin Site Management:
- Admins have control over event categories, user accounts, and event posts.

20. Blog Management:
- Admins can upload, edit, and delete blog content on the website.

21. Security Measures:
- User authentication and password requirements ensure data security.

"Wayzaway" combines user-friendly features, personalized profiles, dynamic content management, and admin control, making it a versatile platform for event sharing and interaction

## Project setup

```
# Setup and start dev server
npm run setup-dev

# Build project
npm run build:full
```
### Customize configuration

See [Configuration Reference](https://vitejs.dev/config/).

## Social Login Configuration

Google and Facebook OAuth require the following environment variables:

```
# Backend (.env)
GOOGLE_CLIENT_ID=<google-client-id>
GOOGLE_CLIENT_SECRET=<google-client-secret>
GOOGLE_CALLBACK_URL=https://api.example.com/auth/google/callback

FACEBOOK_APP_ID=<facebook-app-id>
FACEBOOK_APP_SECRET=<facebook-app-secret>
FACEBOOK_CALLBACK_URL=https://api.example.com/auth/facebook/callback

# Optional: override the frontend route the backend redirects to
SOCIAL_LOGIN_REDIRECT_URL=https://app.example.com/auth/social-callback
```

Set the matching OAuth redirect URIs in the Google Cloud Console and Facebook Developer dashboard so they point to the backend callback URLs shown above.
