# Changelog

## [1.3.2] - 2026-02-26
### Fixed
- Rate limiter responder now reads `rack.attack.match_data` from the request env, restoring proper 429 responses.

## [1.3.1] - 2026-02-26
### Added
- Link request logs to persisted Pokemon records via `pokemon_id`.

### Changed
- Re-enabled persistence for `GET /pokemon/random` (default) while keeping `persist=false` for stateless callers.
- Updated Rack::Attack config to use `throttled_responder` (deprecation fix).
- Disabled Active Storage variants in API-only app to avoid image processing warnings.

## [1.3.0] - 2026-02-26
### Added
- Request logging model + database table for capturing request metadata (method, path, IP, user agent, origin, params, status, duration, metadata).
- Automatic request logging for API requests (excluding the `/up` health check).

### Changed
- `GET /pokemon/random` no longer writes to the `pokemon` table; it now records selected Pokémon details in request log metadata.

## [1.2.0] - 2026-02-24
### Added
- `range=original` option on `GET /pokemon/random` to limit results to the original 151.
- Basic IP rate limiting on `GET /pokemon/random` (configurable via `RATE_LIMIT_PER_MINUTE`).

### Changed
- CORS defaults to the Gameboy web origins when `CORS_ORIGINS` is not set (no wildcard in production).

## [1.1.1] - 2026-02-24
### Changed
- Expanded README into full project documentation (setup, configuration, endpoints, data model).

## [1.1.0] - 2026-02-23
### Added
- Enable CORS via `rack-cors` middleware with `CORS_ORIGINS` support for browser clients.
- `persist=false` option on `GET /pokemon/random` to skip database writes for stateless callers.
- Initial heroku files
- Production database config now mirrors multi-DB setup for cable/queue/cache using `DATABASE_URL`.

### Changed
- CORS configuration now explicitly allows `GET /pokemon/random`.
- Upgraded Ruby to 4.0.1 and Rails to ~> 8.1.2 to match getawd.
- Docker base image now tracks Ruby 4.0.1.

## [1.0.0] - 10/12/2024
### Added
- Initial release with basic functionality for fetching random Pokémon, and populating the postgreSQL database with that info.

### Changed
- Initial release

### Fixed
- N/A

MAJOR: Incremented for incompatible API changes.
MINOR: Incremented for adding functionality in a backwards-compatible manner.
PATCH: Incremented for backwards-compatible bug fixes.

major.minor.patch
