# Random Pokemon Generator API

## Overview
This is a Ruby on Rails API that fetches a random Pokemon from the PokeAPI and optionally stores a subset of the data in PostgreSQL.

## Quickstart
1. `bin/setup`
2. `bin/rails server`
3. `curl http://localhost:3000/pokemon/random`

If you prefer manual setup:
- `bundle install`
- `bin/rails db:prepare`
- `bin/rails server`

## Configuration
- `CORS_ORIGINS`: Comma-separated list of allowed origins for browser clients. If unset, development/test allows localhost and production defaults to the Gameboy web origins.
- `DATABASE_URL`: Required in production; local development uses `config/database.yml`.
- `RATE_LIMIT_PER_MINUTE`: Max requests per minute per IP for `GET /pokemon/random` (defaults to 3).
- `RAILS_MAX_THREADS`: Connection pool size (defaults to 5).

## API
### `GET /pokemon/random`
Returns a random Pokemon payload from the PokeAPI.

Query parameters:
- `persist=false`: Skip the database write. Default behavior persists the Pokemon.

Side effects when `persist` is not `false`:
- Creates a `Pokemon` record with `name`, `external_id`, `height`, `weight`, and `types`.

If rate limited, the API returns `429` with a `Retry-After` header.

### `GET /up`
Rails health check endpoint. Returns `200` if the app boots correctly.

## Data Model
Table: `pokemon`
- `name` (string)
- `external_id` (integer)
- `height` (integer)
- `weight` (integer)
- `types` (jsonb)
- `created_at` / `updated_at`

## Tests
- `bin/rails test`

## Tech Stack
- Ruby 4.0.1
- Rails ~> 8.1.2 (app config still loads 7.1 defaults)
- PostgreSQL
- HTTParty
