const nodeMailer = require("nodemailer");
const { SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASS } = process.env;

const transporter = nodeMailer.createTransport({
  host: SMTP_HOST,
  port: SMTP_PORT,
  secure: true,
  auth: {
    user: SMTP_USER,
    pass: SMTP_PASS
  }
});

async function sendMail(to, subject, html) {
  return transporter.sendMail({
    from: `WayzAway <${SMTP_USER}>`,
    to,
    subject,
    html
  });
}

module.exports = {
  sendMail,
  transporter
};

