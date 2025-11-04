const sharp = require("sharp");
const path = require("path");
const fs = require("fs");
const uploadConfig = require("../config/uploadConfig.js");

function ensureDirSync(dir) {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
}

function compress(configKey) {
  const config = uploadConfig[configKey];
  if (!config) throw new Error(`No sharp config for key: ${configKey}`);
  const dest = path.join(__dirname, "../../public", config.dest);
  ensureDirSync(dest);

  return async (req, res, next) => {
    if (!req.files || req.files.length === 0) return next();
    try {
      req.processedFiles = [];
      for (const file of req.files) {
        const filename = `${config.prefix}-${Date.now()}-${Math.round(Math.random() * 1e5)}.${config.format}`;
        const filepath = path.join(dest, filename);
        await sharp(file.buffer)
          .resize(config.maxWidth)
          .toFormat(config.format, { quality: config.quality })
          .toFile(filepath);
        req.processedFiles.push({
          originalname: file.originalname,
          filename,
          path: filepath,
          url: `/public/${config.dest}/${filename}`
        });
      }
      next();
    } catch (err) {
      next(err);
    }
  };
}

module.exports = { compress };
