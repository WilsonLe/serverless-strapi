const getUrl = ({ env }) => {
	if (process.argv.join(" ").includes("strapi develop")) {
		return undefined;
	} else {
		return env("SERVER_URL");
	}
};

module.exports = ({ env }) => ({
	host: env("HOST", "0.0.0.0"),
	port: env.int("PORT", 1337),
	app: {
		keys: env.array("APP_KEYS")
	},
	url: getUrl({ env }),
	webhooks: {
		defaultHeaders: {
			Authorization: `Bearer ${env("WEBHOOK_TOKEN")}`
		}
	}
});
