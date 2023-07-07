export default ({ env }) => {
  if (!env("CDN_MIDDLEWARE")) {
    throw new Error("CDN_URL não está definido!");
  }

  return [
    "strapi::errors",
    "strapi::security",
    "strapi::cors",
    "strapi::poweredBy",
    "strapi::logger",
    "strapi::query",
    "strapi::body",
    "strapi::session",
    "strapi::favicon",
    "strapi::public",
    {
      name: "strapi::security",
      config: {
        contentSecurityPolicy: {
          useDefaults: true,
          directives: {
            "connect-src": ["'self'", "https:"],
            "img-src": [
              "'self'",
              "data:",
              "blob:",
              "market-assets.strapi.io",
              `${env("CDN_MIDDLEWARE")}`, // Erro será lançado se CDN_MIDDLEWARE_URL não estiver definido
            ],
            "media-src": [
              "'self'",
              "data:",
              "blob:",
              "market-assets.strapi.io",
              `${env("CDN_MIDDLEWARE")}`, // Erro será lançado se CDN_URL não estiver definido
            ],
            upgradeInsecureRequests: null,
          },
        },
      },
    },
  ];
};
