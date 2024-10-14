# app/controllers/pokemons_controller.rb
class PokemonsController < ApplicationController
  def random
    total_pokemon = PokemonService.total_pokemon
    random_id = rand(1..total_pokemon)
    response = PokemonService.fetch_pokemon(random_id)

    # Create a new Pokémon record
    Pokemon.create(
      name: response.parsed_response["name"],
      external_id: response.parsed_response["id"],
      height: response.parsed_response["height"],
      weight: response.parsed_response["weight"],
      types: response.parsed_response["types"]
    )

    render json: response.parsed_response
  end
end