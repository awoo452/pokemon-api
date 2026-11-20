# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/
spec/v2.0.0.html).

## [1.3.32] - 2026-11-20
PM-193 — One version-bump pull request per repo from its Dependabot branches
### Changed
- `Gemfile.lock`: `httparty` 0.24.2 to 0.24.3.
- `Gemfile.lock`: `pg` 1.6.3 to 1.7.0.
- `Gemfile.lock`: `bootsnap` 1.24.6 to 1.26.1.

## [1.3.31] - 2026-11-18
PM-061 — Rails 8.1.4.1 security bump in every app
### Fixed
- `Gemfile.lock`: Rails 8.1.4.1 clears Action Dispatch RemoteIp spoofing (GHSA-2gff-2mmg-m73p).
- `Gemfile.lock`: rails-html-sanitizer 1.7.2, loofah 2.25.3, and nokogiri 1.19.7, which Rails 8.1.4.1 requires.
- `Gemfile.lock`: puma 8.1.2 clears five worker hang and exhaustion advisories (GHSA-jm4r-w4xx-qxw7, GHSA-m5xw-3hrw-qcmf, GHSA-rf6g-xhmp-gm7v, GHSA-x646-wp7c-h9mg, GHSA-xw3h-pgr9-3vg7).
- `Gemfile.lock`: puma 8.1.2 clears pumactl TLS identity and cipher-filter advisories (GHSA-86xc-wrr9-xmmq, GHSA-r885-m39c-939g).
- `Gemfile.lock`: msgpack 1.8.7 clears uncapped JRuby header allocations (CVE-2026-126366).
- `Gemfile.lock`: addressable 2.9.2 clears template ReDoS advisories (GHSA-4w5q-wg7v-w6gp, GHSA-9f42-57jx-vpp3, GHSA-j82w-28jv-3pmj).
- `Gemfile.lock`: addressable 2.9.2 clears URI normalization advisories (GHSA-qq38-m9mg-xjj5, GHSA-8gmh-2hhj-2hv9).
- `Gemfile.lock`: addressable 2.9.2 clears misleading-host advisories (GHSA-539f-xcgw-2gjg, GHSA-9crm-g4mf-wc5j).
- `Gemfile.lock`: crass 1.0.8 clears the CSS sanitizer bypass (GHSA-pq4g-8rxf-4g29).
- `Gemfile.lock`: json 2.21.2 clears the parser use-after-free (CVE-2026-71847).
- `Gemfile.lock`: mail 2.9.1 clears encoded-word address spoofing (GHSA-mvxr-6m87-mv2q).
- `Gemfile.lock`: rack 3.2.8 clears multipart memory exhaustion (GHSA-5v64-555j-wjxm).
- `Gemfile.lock`: rack 3.2.8 clears boundary and static-path bypasses (GHSA-p8x9-v4hv-2w4g, GHSA-wvg4-6p58-3gh3).
- `Gemfile.lock`: rack 3.2.8 clears invalid Host handling (GHSA-2j8w-xcrc-x985).
- `Gemfile.lock`: rubocop 1.92.3 no longer needs mcp, clearing its SSRF advisory (GHSA-4m5j-jjfc-97gx).
- `Gemfile.lock`: brakeman 8.1.0 satisfies the scanner's required latest release.
### Added
- `Gemfile.lock`: a CHECKSUMS block, which the publish gate requires.
### Removed
- `Gemfile.lock`: mcp, json_schemer, hana, and simpleidn, which only the old rubocop needed.
### Changed
- `.github/workflows/ci.yml`: every job runs on Ubuntu 24.04; ubuntu-latest has no Ruby 4.0.2.
- `.github/workflows/ci.yml`: every job has a time limit.
- `.github/workflows/ci.yml`: the gem scan runs `bin/bundler-audit check --update`.

## [1.3.30] - 2026-09-11
### Added
- `CLAUDE.md`: points agents at the Rails Playbook, lists the rules broken most often, and says which of the playbook's `hosting/` notes apply here.
- `AGENTS.md`: sends Codex and other agents to `CLAUDE.md`.
### Changed
- `ai_dev_agent.py`: writes a versioned entry per the playbook's Rule 2 instead of an `## Unreleased` bullet — the bullet names the file, and an uncommitted top entry gets the bullet instead of a new version; drops "small bug fixes" from what it may change, since Rule 10 wants a test it can't write.

## [1.3.29] - 2026-07-20
### Security
- Ran `bundler-audit`, which was failing in CI on `main` — none of these had open dependabot PRs (transitive/indirect dependencies aren't covered by the scheduled version-update config the same way direct Gemfile gems are). Bumped: `rack` 3.2.5 → 3.2.6 (multiple CVEs: multipart parsing DoS/host-spoofing/directory disclosure family), `nokogiri` 1.19.2 → 1.19.4 (multiple use-after-free/out-of-bounds advisories), `rack-session` 2.1.1 → 2.1.2 (GHSA-33qg-7wpp-89cq, secretless session forgery fallback), `loofah` 2.25.1 → 2.25.2, `rails-html-sanitizer` 1.7.0 → 1.7.1 (possible XSS), `crass` 1.0.6 → 1.0.7 (four CSS-parsing DoS advisories), `mcp` 0.10.0 → 0.25.0 (five advisories: memory exhaustion, session poisoning, DNS-rebinding), `websocket-driver` 0.8.0 → 0.8.2 (four advisories), `net-imap` 0.6.3 → 0.6.4.1 (six advisories, dev-only via rubocop/brakeman toolchain, not something this app's runtime touches), `addressable` 2.8.9 → 2.9.0 (ReDoS), `concurrent-ruby` 1.3.6 → 1.3.8, `msgpack` 1.8.0 → 1.8.3 (use-after-free), `json` 2.19.3 → 2.21.1, `erb` 6.0.2 → 6.0.6 (deserialization guard bypass). All transitive, no direct Gemfile changes. `bundler-audit check` and `brakeman` both clean afterward.

## [1.3.28] - 2026-07-20
### Security
- Cleared 5 open dependabot PRs that had been sitting unmerged since 2026-05-29: `puma` 8.0.0 → 8.0.2, `bootsnap` 1.23.0 → 1.24.6, `brakeman` 8.0.4 → 8.0.5, `actions/checkout` v6 → v7, `actions/cache` v5 → v6. Applied directly against `main` via `bundle update`/workflow edit rather than merging the stale PR branches.

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
