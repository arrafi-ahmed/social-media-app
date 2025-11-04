const { sendMail } = require("./transporter");
const { renderTemplate } = require("./config");
const { API_BASE_URL, VUE_BASE_URL } = process.env;

/**
 * Generate and return welcome email HTML and subject
 */
function generateWelcomeEmail({ name, id, vueBaseUrl = VUE_BASE_URL }) {
  const wallUrl = `${vueBaseUrl}/wall/${id}`;
  const html = renderTemplate("welcome", {
    title: "Welcome to WayzAway!",
    name,
    wallUrl
  });
  const subject = `Welcome to WayzAway ${name}!`;
  return { html, subject };
}

/**
 * Generate and return password reset email HTML and subject
 */
function generatePasswordResetEmail({ token, vueBaseUrl = VUE_BASE_URL }) {
  const resetUrl = `${vueBaseUrl}/reset-password/?token=${token}`;
  const html = renderTemplate("password-reset", {
    title: "Reset Your Password",
    resetUrl
  });
  const subject = "Reset Your Password";
  return { html, subject };
}

/**
 * Generate and return invitation email HTML and subject
 */
function generateInvitationEmail({ senderName, message, token, apiBaseUrl = API_BASE_URL }) {
  const acceptUrl = `${apiBaseUrl}/api/user/acceptInvite/?token=${token}`;
  const html = renderTemplate("invitation", {
    title: "You've Been Invited!",
    senderName,
    message,
    acceptUrl
  });
  const subject = "You've been invited to WayzAway";
  return { html, subject };
}

/**
 * Generate and return event created/updated email HTML and subject
 */
function generateEventEmail({ userName, userId, type, vueBaseUrl = VUE_BASE_URL }) {
  const action = type === "add" ? "uploaded" : "updated";
  const wallUrl = `${vueBaseUrl}/wall/${userId}`;
  const html = renderTemplate("event-created", {
    title: `New Event from ${userName}`,
    userName,
    action,
    wallUrl
  });
  const subject = `${userName} has ${action} an event to WayzAway!`;
  return { html, subject };
}

/**
 * Generate and return new comment email HTML and subject
 */
function generateNewCommentEmail({ userId, vueBaseUrl = VUE_BASE_URL }) {
  const wallUrl = `${vueBaseUrl}/wall/${userId}`;
  const html = renderTemplate("new-comment", {
    title: "New Comment on Your Event",
    wallUrl
  });
  const subject = "New Comment on Your Event";
  return { html, subject };
}

/**
 * Generate and return today's event reminder email HTML and subject
 */
function generateTodaysEventEmail({ userId, vueBaseUrl = VUE_BASE_URL }) {
  const wallUrl = `${vueBaseUrl}/wall/${userId}`;
  const html = renderTemplate("todays-event", {
    title: "Event Reminder",
    wallUrl
  });
  const subject = "You have an event scheduled for today!";
  return { html, subject };
}

/**
 * Send welcome email
 */
async function sendWelcomeEmail(to, data) {
  const { html, subject } = generateWelcomeEmail(data);
  return sendMail(to, subject, html);
}

/**
 * Send password reset email
 */
async function sendPasswordResetEmail(to, data) {
  const { html, subject } = generatePasswordResetEmail(data);
  return sendMail(to, subject, html);
}

/**
 * Send invitation email
 */
async function sendInvitationEmail(to, data) {
  const { html, subject } = generateInvitationEmail(data);
  return sendMail(to, subject, html);
}

/**
 * Send event email
 */
async function sendEventEmail(to, data) {
  const { html, subject } = generateEventEmail(data);
  return sendMail(to, subject, html);
}

/**
 * Send new comment email
 */
async function sendNewCommentEmail(to, data) {
  const { html, subject } = generateNewCommentEmail(data);
  return sendMail(to, subject, html);
}

/**
 * Send today's event email
 */
async function sendTodaysEventEmail(to, data) {
  const { html, subject } = generateTodaysEventEmail(data);
  return sendMail(to, subject, html);
}

module.exports = {
  // Core sendMail function
  sendMail,
  
  // Template generation functions (return {html, subject})
  generateWelcomeEmail,
  generatePasswordResetEmail,
  generateInvitationEmail,
  generateEventEmail,
  generateNewCommentEmail,
  generateTodaysEventEmail,
  
  // Combined send functions (generate + send)
  sendWelcomeEmail,
  sendPasswordResetEmail,
  sendInvitationEmail,
  sendEventEmail,
  sendNewCommentEmail,
  sendTodaysEventEmail
};

