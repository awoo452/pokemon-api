# Changelog

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
