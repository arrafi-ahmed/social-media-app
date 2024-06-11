const router = require("express").Router();
const userService = require("../service/user");
const ApiResponse = require("../model/ApiResponse");
const auth = require("../middleware/auth");
const { uploadUser } = require("../middleware/upload");
const CustomError = require("../model/CustomError");
const compressImages = require("../middleware/compress");

router.post("/register", (req, res) => {
  userService
    .register(req.body, req.CLIENT_BASE_URL)
    .then((result) => {
      if (
        result &&
        result.newFriendsCount &&
        result.authData &&
        result.authData.token
      ) {
        res
          .status(201)
          .header("authorization", result.authData.token)
          .json(
            new ApiResponse("Registration successful!", {
              newFriendsCount: result.newFriendsCount,
              currentUser: result.authData.currentUser,
            })
          );
      } else if (result && result.authData && result.authData.token) {
        res
          .status(201)
          .header("authorization", result.authData.token)
          .json(
            new ApiResponse("Registration successful!", {
              currentUser: result.authData.currentUser,
            })
          );
      } else {
        throw new Error();
      }
    })
    .catch((err) => {
      if (err.code == "ER_DUP_ENTRY")
        res.status(500).json(new ApiResponse("Email already taken!", null));
      else res.status(500).json(new ApiResponse("Registration failed!", null));
    });
});

router.post("/signin", (req, res) => {
  userService
    .signin(req.body)
    .then(({ token, currentUser }) => {
      if (token) {
        res
          .status(200)
          .header("authorization", token)
          .json(new ApiResponse("Sign in successful!", { currentUser }));
      } else {
        res
          .status(401)
          .json(new ApiResponse("Incorrect email/password!", null));
      }
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Sign in failed!", null));
    });
});

router.get("/checkFriends", auth, (req, res) => {
  const userId = req.currentUser.id;
  const otherUser = req.query && req.query.otherUser;

  userService
    .checkFriends(userId, otherUser)
    .then((result) => {
      if (result) {
        res.status(200).json(new ApiResponse(null, true));
      } else {
        res.status(200).json(new ApiResponse(null, false));
      }
    })
    .catch((err) => {
      if (err instanceof CustomError) {
        res.status(err.statusCode).json(new ApiResponse(err.message, null));
      } else {
        res
          .status(500)
          .json(new ApiResponse("Checking friend status failed!", null));
      }
    });
});

router.get("/getUserById", auth, (req, res) => {
  const userId = (req.query && req.query.userId) || req.currentUser.id;

  userService
    .getUserById(userId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse(null, null));
    });
});

router.get("/getUserSettings", auth, (req, res) => {
  const userId = req.currentUser.id;

  userService
    .getUserSettings(userId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse(null, null));
    });
});

router.get("/searchUser", auth, (req, res) => {
  const requestedUser = req.query && req.query.requestedUser;

  userService
    .searchUser(requestedUser)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("No user found!", null));
    });
});

router.get("/deleteUser", auth, (req, res) => {
  const userId = (req.query && req.query.userId) || req.currentUser.id;
  const rmImage = (req.query && req.query.rmImage) || null;
  userService
    .deleteUser(userId, rmImage)
    .then((result) => {
      if (result) {
        res
          .status(200)
          .json(new ApiResponse("User deleted successfully!", result));
      } else {
        throw new Error();
      }
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Deleting user failed!", null));
    });
});

router.get("/getFriends", auth, (req, res) => {
  const userId = (req.query && req.query.userId) || req.currentUser.id;

  userService
    .getFriends(userId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Loading friend list failed!", null));
    });
});

router.get("/removeFriend", auth, (req, res) => {
  const userId = (req.query && req.query.userId) || req.currentUser.id;
  const friendshipId = req.query && req.query.friendshipId;

  userService
    .removeFriend(userId, friendshipId)
    .then((result) => {
      if (result) {
        res
          .status(200)
          .json(new ApiResponse("Removed from friend list!", result));
      } else {
        throw new Error();
      }
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Removing friend failed!", null));
    });
});

router.post("/updateProfile", auth, uploadUser, compressImages, (req, res) => {
  const userId = req.currentUser.id;
  userService
    .updateProfile(req.body, req.files, userId)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Profile updated successfully!", result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Profile update failed!", null));
    });
});

router.post("/updateSettings", auth, (req, res) => {
  const userId = req.currentUser.id;
  userService
    .updateSettings(req.body, userId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json(new ApiResponse("Settings update failed!", null));
    });
});

router.post("/sendInvite", auth, (req, res) => {
  const userId = req.currentUser.id;
  userService
    .sendInvite(req.body, userId)
    .then((result) => {
      res.status(200).json(new ApiResponse("Invitation sent!", result));
    })
    .catch((err) => {
      if (err instanceof CustomError) {
        res.status(err.statusCode).json(new ApiResponse(err.message, null));
      } else {
        res
          .status(500)
          .json(new ApiResponse("Invitation sending failed!", null));
      }
    });
});

router.get("/acceptInvite", (req, res) => {
  const token = req.query && req.query.token;

  let clientUrl = req.CLIENT_BASE_URL;
  let apiQueryMsg = "";
  userService
    .acceptInvite(token)
    .then((result) => {
      if (result.redirect === "friends") {
        apiQueryMsg = "Friend invitation accepted!";
        clientUrl += "/friends";
        res.redirect(301, `${clientUrl}?apiQueryMsg=${apiQueryMsg}`);
      } else if (result.redirect === "register") {
        apiQueryMsg = "Friend invitation will be accepted after registration!";
        clientUrl += "/register";
        res.redirect(301, `${clientUrl}?apiQueryMsg=${apiQueryMsg}`);
      }
    })
    .catch((err) => {
      clientUrl += "/register";
      if (err instanceof CustomError) {
        apiQueryMsg = err.message;
        res.redirect(301, `${clientUrl}?apiQueryMsg=${apiQueryMsg}`);
      } else {
        apiQueryMsg = "Invitation accepting failed!";
        res.redirect(301, `${clientUrl}?apiQueryMsg=${apiQueryMsg}`);
      }
    });
});

router.post("/requestResetPass", (req, res) => {
  userService
    .requestResetPass(req.body.resetEmail, req.CLIENT_BASE_URL)
    .then((result) => {
      res
        .status(200)
        .json(
          new ApiResponse("Password reset link sent to your email!", result)
        );
    })
    .catch((err) => {
      if (err instanceof CustomError) {
        res.status(err.statusCode).json(new ApiResponse(err.message, null));
      } else {
        res.status(500).json(new ApiResponse("Password reset failed!", null));
      }
    });
});

router.post("/submitResetPass", (req, res) => {
  userService
    .submitResetPass(req.body)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Password reset successful!", result));
    })
    .catch((err) => {
      if (err instanceof CustomError) {
        res.status(err.statusCode).json(new ApiResponse(err.message, null));
      } else {
        res.status(500).json(new ApiResponse("Password reset failed!", null));
      }
    });
});

router.get("/getProfileWSettings", auth, (req, res) => {
  userService
    .getProfileWSettings(req.currentUser.id)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Email settings load failed!", null));
    });
});

router.get("/updateEmailNewEventNotification", auth, (req, res) => {
  userService
    .updateEmailNewEventNotification(req.query.payload, req.currentUser.id)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Email settings updated successfuly!", result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Email settings update failed!", null));
    });
});

router.get("/updateEmailUpdateEventNotification", auth, (req, res) => {
  userService
    .updateEmailUpdateEventNotification(req.query.payload, req.currentUser.id)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Email settings updated successfuly!", result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Email settings update failed!", null));
    });
});

router.get("/updateEmailNewCommentNotification", auth, (req, res) => {
  userService
    .updateEmailNewCommentNotification(req.query.payload, req.currentUser.id)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Email settings updated successfuly!", result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Email settings update failed!", null));
    });
});

router.get("/addAllUsersToAdminFriendlist", auth, (req, res) => {
  userService
    .addAllUsersToAdminFriendlist(req.currentUser.id)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("All users added as friends!", result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Adding friend failed!", null));
    });
});

module.exports = router;
