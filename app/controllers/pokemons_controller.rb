# app/controllers/pokemons_controller.rb
class PokemonsController < ApplicationController
  def random
    range = original_dex? ? "original" : "all"
    max_id = range == "original" ? 151 : PokemonService.total_pokemon
    random_id = rand(1..max_id)
    response = PokemonService.fetch_pokemon(random_id)
    payload = response.parsed_response

    append_request_log_metadata(
      pokemon: {
        "range" => range,
        "requested_id" => random_id,
        "external_id" => payload["id"],
        "name" => payload["name"],
        "types" => payload["types"],
        "upstream_status" => response.code
      },
      persist_param: params[:persist]
    )

    render json: payload
  end

  private

  def original_dex?
    value = params[:range].to_s.downcase
    value == "original" || value == "gen1" || value == "kanto" || value == "151"
  end
end
