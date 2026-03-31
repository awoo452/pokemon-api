# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/
spec/v2.0.0.html).

## [1.3.27] - 2026-03-30
### Changed
- Updated mcp to 0.10.0 to address CVE-2026-33946.

## [1.3.26] - 2026-03-28
### Changed
- Namespaced database tables with `pokemon_api_` prefixes to avoid collisions in shared databases.
- Corrected schema foreign key to reference `pokemon_id`.

## [1.3.25] - 2026-03-27
### Changed
- Updated pg to 1.6.3.
- Updated debug to 1.11.1.
- Updated bootsnap to 1.23.0.

## [1.3.24] - 2026-03-27
### Changed
- Updated Rails to 8.1.3 to address CVE-2026-33658.

## [1.3.23] - 2026-03-27
### Changed
- Added Dependabot configuration.

## [1.3.22] - 2026-03-23
### Changed
- Documented the HTML legal endpoints in the README for the API-only app.

## [1.3.21] - 2026-03-22
### Changed
- Rendered legal pages with ActionController::Base and updated httparty for security advisory.

## [1.3.20] - 2026-03-22
### Changed
- Fixed legal page rendering in the API controller and added an importmap audit shim.

## [1.3.19] - 2026-03-22
### Changed
- Updated dependencies to address security advisories and generated RuboCop TODO config.

## [1.3.18] - 2026-03-22
### Added
- Added Brakeman, Bundler Audit, and RuboCop Omakase gems plus CI binstubs/config.

## [1.3.17] - 2026-03-22
### Added
- Added binstubs for Brakeman and RuboCop to support CI checks.

## [1.3.16] - 2026-03-21
### Changed
- Standardized CI checks to include security scans, linting, tests, and system tests.

## [1.3.15] - 2026-03-21
### Changed
- Standardized README sections and added legal controller tests.

## [1.3.14] - 2026-03-21
### Changed
- Standardized changelog dates to YYYY-MM-DD.

## [1.3.13] - 2026-03-21
### Fixed
- Removed the unsupported layout call in the legal controller for the API-only app.

## [1.3.12] - 2026-03-21
### Changed
- Standardized legal pages on JSON-backed content and added the Accessibility page.

## [1.3.11] - 2026-03-20
### Added
- Added system test scaffolding and a health check system test.
- Added controller coverage for `GET /pokemon/random`.
- Added GitHub Actions CI with Postgres-backed test and optional system test jobs.
- Added Capybara for system test execution.

### Changed
- Run system tests unconditionally in CI to avoid workflow file parsing issues.
- Synced schema to include the request log Pokemon reference so tests don't report pending migrations.
- Updated the health check system test to assert status for the API-only response body.
- Fixed controller test assertions to compare JSON response bodies correctly.

## [1.3.10] - 2026-03-19
### Changed
- Renamed `PROCFILE` to `Procfile` for Heroku compatibility.
- Upgraded Puma to 7.2.0 and refreshed Gemfile.lock.

## [1.3.9] - 2026-03-19
### Changed
- Refreshed Gemfile.lock via bundle update for Ruby 4.0.2.

## [1.3.8] - 2026-03-19
### Changed
- Pinned Ruby to 4.0.2 across runtime files and Gemfile.lock.

## [1.3.7] - 2026-03-14
### Changed
- Using AI up in this bit

## [1.3.6] - 2026-03-14
### Changed
- Changelog standardization.

## [1.3.5] - 2026-03-10
### Changed
- Defaulted `GET /pokemon/random` to stateless (no DB write) unless `persist=true` is provided.

## [1.3.4] - 2026-02-26
### Changed
- improved README formatting and clarity for setup instructions, configuration, API, and data model

## [1.3.3] - 2026-02-26
### Changed
- README.md updates. U can read them. I am le tired.

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

## [1.0.0] - 2024-10-12
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
