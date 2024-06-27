module.exports = {
  apps: [
    {
      name: "wayzaway-api",
      script: "./app.js",
      env_production: {
        NODE_ENV: "production",
      },
      env_development: {
        NODE_ENV: "development",
      },
      merge_logs: true,
      watch: true,
      error_file: "logs/err.log",
      out_file: "logs/out.log",
      ignore_watch: [
        ".well-known",
        "cgi-bin",
        "logs",
        "node_modules",
        "public",
        "tmp",
      ],
      watch_delay: 1000,
      max_memory_restart: "15G",
      //watch: ["server", "client"],  // Specify which folder to watch
    },
  ],
};
