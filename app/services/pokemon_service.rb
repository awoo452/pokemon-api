# app/services/pokemon_service.rb
class PokemonService
    include HTTParty
    base_uri 'https://pokeapi.co/api/v2'
  
    def self.fetch_pokemon(id)
      get("/pokemon/#{id}")
    end
  
    def self.total_pokemon
      response = get("/pokemon?limit=1")
      response.parsed_response["count"]
    end
  end
  