class ApplicationController < ActionController::API
  around_action :log_request, unless: -> { request.path == "/up" }

  private

  def log_request
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    error = nil
    yield
  rescue => e
    error = e
    raise
  ensure
    duration_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time) * 1000).round
    create_request_log(duration_ms, error)
  end

  def create_request_log(duration_ms, error)
    RequestLog.create(
      request_id: request.request_id,
      http_method: request.request_method,
      path: request.path,
      ip: request.remote_ip,
      user_agent: request.user_agent,
      referer: request.referer,
      origin: request.headers["Origin"],
      params: request_log_params,
      pokemon_id: request_log_pokemon_id,
      status: response&.status || (error ? 500 : nil),
      duration_ms: duration_ms,
      metadata: build_request_log_metadata(error)
    )
  rescue => log_error
    Rails.logger.warn("RequestLog failed: #{log_error.class}: #{log_error.message}")
  end

  def request_log_params
    filtered = request.filtered_parameters || {}
    filtered = filtered.except("controller", "action")
    filtered.presence
  end

  def build_request_log_metadata(error)
    metadata = request.env["request_log.metadata"]
    metadata = metadata.is_a?(Hash) ? metadata.deep_stringify_keys : {}
    if error
      metadata["error"] = {
        "class" => error.class.name,
        "message" => error.message
      }
    end
    metadata.presence
  end

  def request_log_pokemon_id
    raw = request.env["request_log.pokemon_id"]
    return if raw.blank?

    raw.to_i
  end

  def append_request_log_metadata(data)
    return if data.blank?

    existing = request.env["request_log.metadata"]
    existing = existing.is_a?(Hash) ? existing : {}
    request.env["request_log.metadata"] = existing.merge(data)
  end

  def set_request_log_pokemon_id(pokemon_id)
    request.env["request_log.pokemon_id"] = pokemon_id
  end
end
