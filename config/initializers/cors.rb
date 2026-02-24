# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  default_prod_origins = [
    "https://master.d3dcxsy0hkmbvn.amplifyapp.com",
    "https://gameboy.getawd.com"
  ]

  origins_env = ENV.fetch("CORS_ORIGINS", "")
  origins_list = origins_env.split(",").map(&:strip).reject(&:empty?)

  if origins_list.empty?
    if Rails.env.development? || Rails.env.test?
      origins_list = ["http://localhost:3000", "http://127.0.0.1:3000"]
    else
      origins_list = default_prod_origins
      Rails.logger.info("CORS_ORIGINS is not set; defaulting to #{origins_list.join(', ')}.")
    end
  end

  if origins_list.any?
    allow do
      origins(*origins_list)

      resource "*",
        headers: :any,
        methods: [:get, :options, :head]
    end
  end
end
