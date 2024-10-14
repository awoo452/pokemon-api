# README

# Random Pokemon Generator

## Description
This is a Ruby on Rails API application that interfaces with the Pokémon API to retrieve and store Pokémon data. The application allows users to request random Pokémon and automatically saves some of their relevant details to a PostgreSQL database. 

## Features
- Fetches a random Pokémon from the Pokémon API.
- Stores relevant Pokémon data in a PostgreSQL database, including:
  - Name
  - External ID
  - Height
  - Weight
  - Types (stored as a JSONB field for flexibility)
- Follows RESTful conventions for API design.

## Technologies Used
- Ruby on Rails (version 7.1.4)
- PostgreSQL (as the database)
- RSpec (for testing)
- [Pokémon API](https://pokeapi.co/api/v2/)

## Setup Instructions

### Prerequisites
- Ruby (version 3.2)
- Rails (version 7.1.4)
- PostgreSQL (version 14.13)
- Git (version 2.0 or higher)
- Bundler (Version 2.5.17)

### Installation

1. Clone the repository:

   ```bash

   git clone https://github.com/awoo452/pokemon_api.git

2. Figure out how to make it work

## Usage Instructions

### API Endpoints

The application exposes the following API endpoint:

- **GET** `/pokemon/random`:  
  Generates a random Pokémon. This endpoint retrieves a Pokémon from the Pokémon API and saves some of its relevant details to the database.

### Example Request

To fetch a random Pokémon, you can use `curl`, Postman, or any HTTP client. Here’s an example using `curl`:

```bash
curl -X GET http://localhost:3000/pokemon/random
