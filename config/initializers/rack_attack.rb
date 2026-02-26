# Rate limiting for public API endpoints.

require "rack/attack"

cache_store = Rails.cache
if cache_store.is_a?(ActiveSupport::Cache::NullStore)
  cache_store = ActiveSupport::Cache::MemoryStore.new
end
Rack::Attack.cache.store = cache_store

RATE_LIMIT_PER_MINUTE = ENV.fetch("RATE_LIMIT_PER_MINUTE", "3").to_i

Rack::Attack.throttle("pokemon/random by ip", limit: RATE_LIMIT_PER_MINUTE, period: 1.minute) do |req|
  if req.get? && req.path == "/pokemon/random"
    req.ip
  end
end

Rack::Attack.throttled_responder = lambda do |env|
  match_data = env["rack.attack.match_data"] || {}
  period = match_data[:period].to_i
  retry_after = period.positive? ? (period - (Time.now.to_i % period)) : 60

  body = {
    error: "rate_limited",
    message: "Too many requests. Try again soon."
  }.to_json

  [
    429,
    {
      "Content-Type" => "application/json",
      "Retry-After" => retry_after.to_s
    },
    [body]
  ]
end

Rails.application.config.middleware.use Rack::Attack
