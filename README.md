# Random Pokemon Generator API

## Overview

This Ruby on Rails API fetches a random Pokémon from the PokeAPI, logs each request, and can optionally store a subset of the data in PostgreSQL.

## Quickstart

1. Run `bin/setup`
2. Start the server: `bin/rails server`
3. Fetch a random Pokémon:  
   `curl http://localhost:3000/pokemon/random`

**Manual setup:**
- Install dependencies: `bundle install`
- Prepare the database: `bin/rails db:prepare`
- Start the server: `bin/rails server`

## Configuration

- `CORS_ORIGINS` — Comma-separated list of allowed origins for browser clients.  
  - If unset:  
    - Development/test: allows localhost  
    - Production: defaults to Gameboy web origins
- `DATABASE_URL` — Required in production; local development uses `config/database.yml`.
- `RATE_LIMIT_PER_MINUTE` — Max requests per minute per IP for `GET /pokemon/random` (default: 3).
- `RAILS_MAX_THREADS` — Connection pool size (default: 5).

## API

### `GET /pokemon/random`

Returns a random Pokémon payload from the PokeAPI.

#### Query parameters:
- `persist=false` — Skip writing to the database (default persists the Pokémon).
- `range=original` — Limit results to the original 151 Pokémon.

#### Side effects (when `persist` is not `false`):
- Creates a `Pokemon` record with:
  - `name`
  - `external_id`
  - `height`
  - `weight`
  - `types`
- Links the request log to the created Pokémon via `pokemon_id`.

#### Request logging:
- All API requests except `GET /up` are logged in the `request_logs` table.
- Each log captures request metadata such as:
  - HTTP method
  - Path
  - IP address
  - User agent
  - Origin
  - Params
  - Status
  - Duration
  - Metadata

#### Rate limiting:
- If rate limited, returns HTTP `429` with a `Retry-After` header.

### `GET /up`

Rails health check endpoint. Returns `200` if the app is running.

## Data Model

**Table: `pokemon`**
- `name` (string)
- `external_id` (integer)
- `height` (integer)
- `weight` (integer)
- `types` (jsonb)
- `created_at` / `updated_at`

**Table: `request_logs`**
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

## Tests

Run the tests with:

```
bin/rails test
```

## Tech Stack

- Ruby 4.0.1
- Rails ~> 8.1.2 (app config still loads 7.1 defaults)
- PostgreSQL
- HTTParty

---

*Pokémon and Pokémon character names are trademarks of Nintendo.*