# app/controllers/pokemons_controller.rb
class PokemonsController < ApplicationController
  def random
    max_id = if original_dex?
      151
    else
      PokemonService.total_pokemon
    end
    random_id = rand(1..max_id)
    response = PokemonService.fetch_pokemon(random_id)

    persist = params.fetch(:persist, "true") != "false"
    if persist
      # Create a new Pokémon record
      Pokemon.create(
        name: response.parsed_response["name"],
        external_id: response.parsed_response["id"],
        height: response.parsed_response["height"],
        weight: response.parsed_response["weight"],
        types: response.parsed_response["types"]
      )
    end

    render json: response.parsed_response
  end

  private

  def original_dex?
    value = params[:range].to_s.downcase
    value == "original" || value == "gen1" || value == "kanto" || value == "151"
  end
end
