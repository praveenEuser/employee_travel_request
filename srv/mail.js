const nodemailer = require("nodemailer");

function createTransporter() {
  const host = process.env.SMTP_HOST;
  const port = Number(process.env.SMTP_PORT || 587);
  const user = process.env.SMTP_USER;
  const pass = process.env.SMTP_PASS;

  if (!host || !user || !pass) {
    console.error("❌ SMTP credentials missing. Email will not be sent.");
    return null;
  }

  return nodemailer.createTransport({
    host,
    port,
    secure: port === 465,
    auth: { user, pass },
    tls: { rejectUnauthorized: false }
  });
}

const transporter = createTransporter();

async function sendMail({ to, cc, subject, text, html, replyTo }) {
  if (!transporter) return;

  return transporter.sendMail({
    from: `"Travel App" <${process.env.SMTP_USER}>`,   // mediator sender
    to,
    cc,
    subject,
    text,
    html,
    replyTo
  });
}

module.exports = { sendMail };
