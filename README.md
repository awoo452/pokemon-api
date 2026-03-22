# Random Pokemon Generator API

## Features

A Ruby on Rails API that fetches a random Pokémon from the PokeAPI, logs each request, and can optionally store a subset of the data in PostgreSQL.

### API

`GET /pokemon/random` returns a random Pokémon payload from the PokeAPI.

Query parameters:
- `persist=false` skips writing to the database (default persists the Pokémon).
- `range=original` limits results to the original 151 Pokémon.

Side effects (when `persist` is not `false`):
- Creates a `Pokemon` record with `name`, `external_id`, `height`, `weight`, `types`.
- Links the request log to the created Pokémon via `pokemon_id`.

Request logging:
- All API requests except `GET /up` are logged in the `request_logs` table.
- Each log captures request metadata (HTTP method, path, IP address, user agent, origin, params, status, duration, metadata).

Rate limiting:
- If rate limited, returns HTTP `429` with a `Retry-After` header.

`GET /up` is the Rails health check endpoint.

### Configuration

- `CORS_ORIGINS` — Comma-separated list of allowed origins for browser clients.
  - If unset: development/test allow localhost; production defaults to Gameboy web origins.
- `DATABASE_URL` — Required in production; local development uses `config/database.yml`.
- `RATE_LIMIT_PER_MINUTE` — Max requests per minute per IP for `GET /pokemon/random` (default: 3).
- `RAILS_MAX_THREADS` — Connection pool size (default: 5).

### Data Model

Table: `pokemon`
- `name` (string)
- `external_id` (integer)
- `height` (integer)
- `weight` (integer)
- `types` (jsonb)
- `created_at` / `updated_at`

Table: `request_logs`
- `request_id` (string)
- `http_method` (string)
- `path` (string)
- `ip` (string)
- `user_agent` (string)
- `referer` (string)
- `origin` (string)
- `params` (jsonb)
- `status` (integer)
- `duration_ms` (integer)
- `metadata` (jsonb)
- `pokemon_id` (foreign key, nullable)
- `created_at` / `updated_at`

## Setup

1. `bin/setup`

Manual setup:
- `bundle install`
- `bin/rails db:prepare`

## Run

1. `bin/rails server`

## Tests

1. `bin/rails test`
2. `bin/rails test:system`

## Changelog

See [`CHANGELOG.md`](CHANGELOG.md) for notable changes.

Pokémon and Pokémon character names are trademarks of Nintendo.
