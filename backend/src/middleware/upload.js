const multer = require("multer");
const path = require("path");
const fs = require("fs");
const uploadConfig = require("../config/uploadConfig.js");
const CustomError = require("../model/CustomError");

function ensureDirSync(dir) {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
}

function upload(configKey) {
  const config = uploadConfig[configKey];
  if (!config) throw new Error(`No upload config for key: ${configKey}`);
  const dest = path.join(__dirname, "../../public", config.dest);
  ensureDirSync(dest);

  const storage = multer.memoryStorage();
  const fileFilter = (req, file, cb) => {
    const ext = path.extname(file.originalname).toLowerCase();
    if (!config.allowedExts.includes(ext)) {
      return cb(new Error(`Invalid file type: ${ext}`), false);
    }
    cb(null, true);
  };

  const uploader = multer({
    storage,
    limits: { fileSize: config.maxSize },
    fileFilter
  });

  if (config.maxCount === 1) {
    return (req, res, next) => {
      uploader.single(config.fieldName || "file")(req, res, function(err) {
        if (err) {
          // Handle MulterError for file size
          if (err instanceof multer.MulterError && err.code === "LIMIT_FILE_SIZE") {
            const maxSizeMB = (config.maxSize / (1024 * 1024)).toFixed(1);
            return next(new CustomError(`File too large! Maximum allowed size is ${maxSizeMB}MB.`, 400));
          }
          // Handle file filter errors
          if (err.message && err.message.startsWith("Invalid file type")) {
            return next(new CustomError(err.message, 400));
          }
          return next(err);
        }
        // Save file to disk if present
        if (req.file) {
          const ext = path.extname(req.file.originalname).toLowerCase();
          const filename = `${config.prefix || "file"}-${Date.now()}${ext}`;
          const destPath = path.join(dest, filename);
          fs.writeFileSync(destPath, req.file.buffer);
          req.processedFiles = [{
            filename,
            path: destPath,
            originalname: req.file.originalname,
            mimetype: req.file.mimetype,
            size: req.file.size
          }];
        }
        next();
      });
    };
  } else {
    return (req, res, next) => {
      uploader.array(config.fieldName || "file", config.maxCount || 5)(req, res, function(err) {
        if (err) {
          // Handle MulterError for file size
          if (err instanceof multer.MulterError && err.code === "LIMIT_FILE_SIZE") {
            const maxSizeMB = (config.maxSize / (1024 * 1024)).toFixed(1);
            return next(new CustomError(`File too large! Maximum allowed size is ${maxSizeMB}MB.`, 400));
          }
          // Handle file filter errors
          if (err.message && err.message.startsWith("Invalid file type")) {
            return next(new CustomError(err.message, 400));
          }
          return next(err);
        }
        next();
      });
    };
  }
}

module.exports = { upload };

// const uploadEvent = createUpload("event");
// const uploadUser = createUpload("user");
// const uploadBlog = createUpload("blog");
// const uploadPage = createUpload("page");
