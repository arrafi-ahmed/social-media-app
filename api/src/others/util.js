const fs = require("fs").promises;
const path = require("path");
const { API_BASE_URL, VUE_BASE_URL, ANDROID_BASE_URL } = process.env;

const dirMap = {
  event: path.join(__dirname, "..", "..", "public", "event"),
  user: path.join(__dirname, "..", "..", "public", "user"),
  blog: path.join(__dirname, "..", "..", "public", "blog"),
  page: path.join(__dirname, "..", "..", "public", "page"),
  temp: path.join(__dirname, "..", "..", "public", "temp"),
};

const getPrefix = (filename) => {
  return filename.split("-")[0];
};

const getDirPath = (prefix) => {
  return dirMap[prefix];
};

const getFilePath = (filename, prefix) => {
  const calcPrefix = prefix || getPrefix(filename);
  return path.join(dirMap[calcPrefix], filename);
};

const removeImages = async (imageArr) => {
  imageArr.map((image) => {
    const filePath = getFilePath(image);
    if (filePath) {
      return fs.unlink(filePath);
    } else {
      console.error("removeImages() - Invalid file path:", filePath);
      return Promise.resolve(); // Return a resolved promise to prevent further errors.
    }
  });
};

const moveImage = (sourcePath, destinationPath) => {
  return fs.rename(sourcePath, destinationPath);
};

const applink = `
  <a href="https://play.google.com/store/apps/details?id=app.wayzaway.online&pcampaignid=web_share" target="_blank">
    <img src="${VUE_BASE_URL}/img/badge-google-play.png" alt="Download on Google Play" width="110" height="40">
  </a><br>
  <a href="https://apps.apple.com/us/app/wayzaway-lifestyle-journal/id6497877312" target="_blank">
    <img src="${VUE_BASE_URL}/img/badge-app-store.png" alt="Download on App Store" width="105" height="35">
  </a>
`;

const generatePassResetContent = (token, CLIENT_BASE_URL) => {
  return `
    <p>Hello</p>
    <p>Click the button to reset password, will be valid for 1 hour.</p>
    <a href="${CLIENT_BASE_URL}/reset-password/?token=${token}"><button style="background-color: #e40046; color: white; border: none; padding: 10px;">Reset Password</button></a>
    <p>Best wishes,<br>WayzAway</p>
    <br><br>${applink}
`;
};

const generateInvitationContent = ({ full_name }, message, token) => {
  return `
    <p>Hello</p>
    <p>You got a new invitation from ${full_name}</p>
    <p style="padding: 12px; border-left: 4px solid #d0d0d0; font-style: italic;">${message}</p>
    <a href="${API_BASE_URL}/api/user/acceptInvite/?token=${token}"><button style="background-color: #e40046;color:white;border:none;padding:10px">Accept Invitation</button></a>
    <p>Best wishes,<br>WayzAway</p>
    <br><br>${applink}
`;
};

const generateWelcomeContent = (name, id, CLIENT_BASE_URL) => {
  return `
  <p>Hello ${name},</p>
  <p><strong>Welcome to WayzAway!</strong></p>
  <p>Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go?</p>
  <a href="${CLIENT_BASE_URL}/wall/${id}"><button style="background-color: #e40046; color: white; border: none; padding: 10px;">Visit your account</button></a>
  <p>Best wishes,<br>WayzAway</p>
  <br><br>${applink}
`;
};

const generatePostCreationContent = (user, type, CLIENT_BASE_URL) => {
  return `
  <p>From <b>${user.full_name}:</b></p>
  <p>"I have ${
    type === "add" ? "uploaded" : "updated"
  } a new event to my WayzAway. Sign in below to have a look!"</p>
  <a href="${CLIENT_BASE_URL}/wall/${
    user.id
  }"><button style="background-color: #e40046; color: white; border: none; padding: 10px;">Sign in</button></a>
  <p>Best wishes,<br>WayzAway</p>
  <br><br>${applink}
`;
};

const generateNewCommentContent = (user, CLIENT_BASE_URL) => {
  return `
  <p>Someone has commented on your event, log back into your account to have a look.</p>
  <a href="${CLIENT_BASE_URL}/wall/${user.id}"><button style="background-color: #e40046; color: white; border: none; padding: 10px;">Sign in</button></a>
  <p>Best wishes,<br>WayzAway</p>
  <br><br>${applink}
`;
};

const generateTodaysEventContent = (user, CLIENT_BASE_URL) => {
  return `
  <p>You have an event scheduled for today. Sign into your Wayzaway account to have a look.</p>
  <a href="${CLIENT_BASE_URL}/wall/${user.id}"><button style="background-color: #e40046; color: white; border: none; padding: 10px;">Sign in</button></a>
  <p>Best wishes,<br>WayzAway</p>
  <br><br>${applink}
`;
};

module.exports = {
  API_BASE_URL,
  VUE_BASE_URL,
  ANDROID_BASE_URL,
  dirMap,
  generatePassResetContent,
  generateInvitationContent,
  generateWelcomeContent,
  generatePostCreationContent,
  generateNewCommentContent,
  generateTodaysEventContent,
  moveImage,
  getFilePath,
  getDirPath,
  getPrefix,
  removeImages,
};
