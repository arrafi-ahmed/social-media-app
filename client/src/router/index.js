// Composables
import { createRouter, createWebHistory } from "vue-router";

const routes = [
  {
    path: "/",
    component: () => import("@/layouts/headerless/Headerless.vue"),
    children: [
      {
        path: "",
        name: "landing",
        component: () => import("@/views/Landing.vue"),
        meta: {
          requiresNoAuth: true,
        },
      },
    ],
  },
  {
    path: "/",
    component: () => import("@/layouts/default/Default.vue"),
    children: [
      {
        path: "register",
        name: "register",
        component: () => import("@/views/Register.vue"),
        meta: {
          requiresNoAuth: true,
        },
      },
      {
        path: "signin",
        name: "signin",
        component: () => import("@/views/Signin.vue"),
        meta: {
          requiresNoAuth: true,
        },
      },
      {
        path: "wall/:id/add",
        name: "eventAdd",
        component: () => import("@/views/EventAdd.vue"),
        props: true,
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "wall/event/edit/:eventId",
        name: "eventEdit-wall",
        component: () => import("@/views/EventEdit.vue"),
        props: true,
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "wall/:id",
        name: "wall",
        component: () => import("@/views/Wall.vue"),
        props: true,
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "browse/event/edit/:eventId",
        name: "eventEdit-browse",
        component: () => import("@/views/EventEdit.vue"),
        props: true,
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "browse",
        name: "browse",
        component: () => import("@/views/Browse.vue"),
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "friends",
        name: "friends",
        component: () => import("@/views/Friends.vue"),
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "event/:id",
        name: "eventSingle",
        component: () => import("@/views/EventSingle.vue"),
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "favorite",
        name: "favorite",
        component: () => import("@/views/Favorite.vue"),
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "wishlist/edit/:eventId",
        name: "wishlistEdit",
        component: () => import("@/views/WishlistEdit.vue"),
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "wishlist/:id/add",
        name: "wishlistAdd",
        component: () => import("@/views/WishlistAdd.vue"),
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "wishlist/:id",
        name: "wishlistSingle",
        component: () => import("@/views/WishlistSingle.vue"),
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "wishlist",
        name: "wishlist",
        component: () => import("@/views/Wishlist.vue"),
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "settings",
        name: "settings",
        component: () => import("@/views/Settings.vue"),
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "blog",
        name: "blog",
        component: () => import("@/views/Blog.vue"),
        meta: {},
      },
      {
        path: "blog/:id",
        name: "blogSingle",
        component: () => import("@/views/BlogSingle.vue"),
        meta: {},
      },
      {
        path: "terms",
        name: "terms",
        component: () => import("@/views/Page.vue"),
        meta: {},
      },
      {
        path: "about",
        name: "about",
        component: () => import("@/views/Page.vue"),
        meta: {},
      },
      {
        path: "privacy",
        name: "privacy",
        component: () => import("@/views/Page.vue"),
        meta: {},
      },
      {
        path: "reset-password",
        name: "resetPass",
        component: () => import("@/views/ResetPassword.vue"),
        meta: {
          requiresNoAuth: true,
        },
      },
      {
        path: "signout",
        name: "signout",
        component: () => import("@/views/Signout.vue"),
        meta: {
          requiresAuth: true,
        },
      },
      {
        path: "pricing",
        name: "pricing",
        component: () => import("@/views/Pricing.vue"),
        meta: {},
      },
      {
        path: "/admin/dashboard",
        name: "adminDashboard",
        component: () => import("@/views/Admin.vue"),
        meta: {
          requiresAdmin: true,
        },
      },
    ],
  },
  {
    path: "",
    redirect: { name: "landing" },
  },
  {
    path: "/not-found/:status?/:message?",
    name: "notFound",
    component: () => import("@/views/NotFound.vue"),
    props: (route) => ({
      status: route.params.status || 404,
      message: route.params.message || "Looks like you're lost!",
    }),
    meta: {},
  },
  {
    path: "/:catchAll(.*)",
    redirect: {
      name: "notFound",
      params: { status: 404, message: "Looks like you're lost!" },
    },
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
