const handlebars = require("handlebars");
const fs = require("fs");
const path = require("path");
const { VUE_BASE_URL } = process.env;
const { appInfo } = require("../others/util");

// Template directories
const templatesDir = path.join(__dirname, "templates", "hbs");
const partialsDir = path.join(__dirname, "templates", "hbs", "partials");

// Register Handlebars helpers
handlebars.registerHelper("eq", function(a, b) {
  return a === b;
});

handlebars.registerHelper("formatDate", function(date) {
  if (!date) return "";
  return new Date(date).toLocaleDateString();
});

// Load and register partials
function loadPartials() {
  if (fs.existsSync(partialsDir)) {
    const files = fs.readdirSync(partialsDir);
    files.forEach(file => {
      if (file.endsWith(".hbs")) {
        const partialName = file.replace(".hbs", "");
        const partialPath = path.join(partialsDir, file);
        const partialContent = fs.readFileSync(partialPath, "utf8");
        handlebars.registerPartial(partialName, partialContent);
      }
    });
  }
}

// Load base template first
const baseTemplatePath = path.join(templatesDir, "base.hbs");
const baseTemplateContent = fs.readFileSync(baseTemplatePath, "utf8");
handlebars.registerPartial("base", baseTemplateContent);

// Load other partials
loadPartials();

// Load and compile templates
const templates = {};

function loadTemplates() {
  const files = fs.readdirSync(templatesDir);
  
  files.forEach(file => {
    if (file.endsWith(".hbs") && file !== "base.hbs") {
      const templateName = file.replace(".hbs", "");
      const templatePath = path.join(templatesDir, file);
      const templateContent = fs.readFileSync(templatePath, "utf8");
      templates[templateName] = handlebars.compile(templateContent);
    }
  });
}

// Initialize templates on load
loadTemplates();

// Render template with data
function renderTemplate(templateName, data = {}) {
  if (!templates[templateName]) {
    throw new Error(`Template ${templateName} not found`);
  }
  
  // Add global variables available to all templates
  const templateData = {
    ...data,
    vueBaseUrl: VUE_BASE_URL,
    appName: appInfo.name
  };
  
  return templates[templateName](templateData);
}

module.exports = {
  renderTemplate,
  templates,
  handlebars
};

