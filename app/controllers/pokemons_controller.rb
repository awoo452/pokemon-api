# app/controllers/pokemons_controller.rb
class PokemonsController < ApplicationController
  def random
    range = original_dex? ? "original" : "all"
    max_id = range == "original" ? 151 : PokemonService.total_pokemon
    random_id = rand(1..max_id)
    response = PokemonService.fetch_pokemon(random_id)
    payload = response.parsed_response

    pokemon_record = nil
    persist = params.fetch(:persist, "true") != "false"
    if persist && payload.is_a?(Hash)
      pokemon_record = Pokemon.create(
        name: payload["name"],
        external_id: payload["id"],
        height: payload["height"],
        weight: payload["weight"],
        types: payload["types"]
      )
      set_request_log_pokemon_id(pokemon_record.id)
    end

    append_request_log_metadata(
      pokemon: {
        "range" => range,
        "requested_id" => random_id,
        "external_id" => payload["id"],
        "name" => payload["name"],
        "types" => payload["types"],
        "upstream_status" => response.code
      },
      persist_param: params[:persist],
      pokemon_id: pokemon_record&.id
    )

    render json: payload
  end

  private

  def original_dex?
    value = params[:range].to_s.downcase
    value == "original" || value == "gen1" || value == "kanto" || value == "151"
  end
end
