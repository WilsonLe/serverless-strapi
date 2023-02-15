module.exports = ({ env }) => ({
	upload: {
		config: {
			provider: "aws-s3",
			providerOptions: {
				accessKeyId: env("AWS_BUCKET_ACCESS_KEY_ID"),
				secretAccessKey: env("AWS_BUCKET_ACCESS_SECRET"),
				region: env("AWS_BUCKET_REGION"),
				params: {
					Bucket: env("AWS_BUCKET_NAME")
				}
			},
			actionOptions: {
				upload: { ACL: "public-read" },
				uploadStream: { ACL: "public-read" },
				delete: {}
			}
		}
	},
	editor: {
		ckeditor: true
	},
	"strapi-plugin-populate-deep": {
		config: {
			defaultDepth: 5
		}
	}
});
