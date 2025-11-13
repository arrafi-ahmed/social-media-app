const router = require("express").Router();
const { auth } = require("../middleware/auth");
const { upload } = require("../middleware/upload");
const ApiResponse = require("../model/ApiResponse");
const CustomError = require("../model/CustomError");
const { VUE_BASE_URL } = require("../others/util");
const userService = require("../service/user");
const { compress } = require("../middleware/compress");

router.get("/checkFriends", auth, async (req, res, next) => {
  try {
    const userId = req.currentUser.id;
    const otherUser = req.query?.otherUser;

    const result = await userService.checkFriends(userId, otherUser);
    if (result) {
      res.status(200).json(new ApiResponse(null, true));
    } else {
      res.status(200).json(new ApiResponse(null, false));
    }
  } catch (error) {
    return next(error);
  }
});

router.get("/getUserById", auth, async (req, res, next) => {
  try {
    const userId = req.query?.userId || req.currentUser.id;

    const result = await userService.getUserById(userId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getUserBySlug", auth, async (req, res, next) => {
  try {
    const slug = req.query?.slug;

    if (!slug) {
      throw new CustomError("Slug parameter is required!", 400);
    }

    const result = await userService.getUserBySlug(slug);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getUserSettings", auth, async (req, res, next) => {
  try {
    const userId = req.currentUser.id;

    const result = await userService.getUserSettings(userId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/searchUser", auth, async (req, res, next) => {
  try {
    const requestedUser = req.query?.requestedUser;

    const result = await userService.searchUser(requestedUser);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/deleteUser", auth, async (req, res, next) => {
  try {
    const userId = req.query?.userId || req.currentUser.id;
    const rmImage = req.query?.rmImage || null;

    const result = await userService.deleteUser(userId, rmImage);
    if (result) {
      res
        .status(200)
        .json(new ApiResponse("User deleted successfully!", result));
    } else {
      throw new Error();
    }
  } catch (error) {
    return next(error);
  }
});

router.get("/getFriends", auth, async (req, res, next) => {
  try {
    const userId = req.query?.userId || req.currentUser.id;

    const result = await userService.getFriends(userId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/removeFriend", auth, async (req, res, next) => {
  try {
    const userId = req.query?.userId || req.currentUser.id;
    const friendshipId = req.query?.friendshipId;

    // Check if friendshipId is provided
    if (friendshipId === undefined || friendshipId === null || friendshipId === '') {
      return res.status(400).json(new ApiResponse("Friendship ID is required", null));
    }

    // Convert to integer to ensure type matching
    const friendshipIdInt = parseInt(friendshipId, 10);
    const userIdInt = parseInt(userId, 10);

    if (isNaN(friendshipIdInt) || isNaN(userIdInt)) {
      return res.status(400).json(new ApiResponse("Invalid friendship ID or user ID", null));
    }

    const result = await userService.removeFriend(userIdInt, friendshipIdInt);
    if (result && result.rowCount > 0) {
      res
        .status(200)
        .json(new ApiResponse("Removed from friend list!", result));
    } else {
      return res.status(404).json(new ApiResponse("Friendship not found or could not be removed", null));
    }
  } catch (error) {
    return next(error);
  }
});

router.post(
  "/updateProfile",
  auth,
  upload("user"), compress("user"),
  async (req, res, next) => {
    try {
      const userId = req.currentUser.id;
      const result = await userService.updateProfile(
        req.body,
        req.processedFiles || req.files,
        userId
      );
      res
        .status(200)
        .json(new ApiResponse("Profile updated successfully!", result));
    } catch (error) {
      return next(error);
    }
  }
);

router.post("/updateSettings", auth, async (req, res, next) => {
  try {
    const userId = req.currentUser.id;
    const result = await userService.updateSettings(req.body, userId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.post("/sendInvite", auth, async (req, res, next) => {
  try {
    const userId = req.currentUser.id;
    const { successfulInvites, failedInvites } = await userService.sendInvite(
      req.body,
      userId
    );

    const messages = [];

    if (successfulInvites.length > 0) {
      messages.push("Invitation sent successfully to:");
      messages.push(successfulInvites.map((item) => item.email).join("\n"));
    }

    if (failedInvites.length > 0) {
      if (successfulInvites.length > 0) {
        messages.push("\n");
      }
      messages.push("Invitation sending failed for:");
      messages.push(
        failedInvites
          .map((item) => `${item.email}, Error: ${item.errorMessage}`)
          .join("\n")
      );
      throw new CustomError(messages.join("\n"), 400, { successfulInvites, failedInvites });
    }

    const msg = messages.join("\n");
    res
      .status(200)
      .json(new ApiResponse(msg, { successfulInvites, failedInvites }));
  } catch (error) {
    return next(error);
  }
});

router.get("/acceptInvite", (req, res) => {
  const token = req.query?.token;
  const redirectUrl = new URL(`${VUE_BASE_URL}/friends/accept`);
  if (token) {
    redirectUrl.searchParams.set("token", token);
  }
  res.redirect(301, redirectUrl.toString());
});

router.get("/invite/preview", async (req, res, next) => {
  try {
    const token = req.query?.token;
    const result = await userService.previewInvite(token);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.post("/acceptInvite", auth, async (req, res, next) => {
  try {
    const token = req.body?.token;
    const result = await userService.acceptInvite(token, req.currentUser.id);
    res
      .status(200)
      .json(new ApiResponse("Friend invitation accepted!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getProfileWSettings", auth, async (req, res, next) => {
  try {
    const result = await userService.getProfileWSettings(req.currentUser.id);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/updateEmailNewEventNotification", auth, async (req, res, next) => {
  try {
    const result = await userService.updateEmailNewEventNotification(
      req.query.payload,
      req.currentUser.id
    );
    res
      .status(200)
      .json(new ApiResponse("Email settings updated successfuly!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/updateEmailUpdateEventNotification", auth, async (req, res, next) => {
  try {
    const result = await userService.updateEmailUpdateEventNotification(
      req.query.payload,
      req.currentUser.id
    );
    res
      .status(200)
      .json(new ApiResponse("Email settings updated successfuly!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/updateEmailNewCommentNotification", auth, async (req, res, next) => {
  try {
    const result = await userService.updateEmailNewCommentNotification(
      req.query.payload,
      req.currentUser.id
    );
    res
      .status(200)
      .json(new ApiResponse("Email settings updated successfuly!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/addAllUsersToAdminFriendlist", auth, async (req, res, next) => {
  try {
    const result = await userService.addAllUsersToAdminFriendlist(
      req.currentUser.id
    );
    res
      .status(200)
      .json(new ApiResponse("All users added as friends!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/search", auth, async (req, res, next) => {
  try {
    const query = req.query?.q || "";
    const limit = req.query?.limit ? parseInt(req.query.limit, 10) : 10;
    const userId = req.currentUser.id;
    const result = await userService.searchUsers(query, userId, limit);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

module.exports = router;
