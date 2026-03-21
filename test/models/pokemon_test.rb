require "test_helper"

class PokemonTest < ActiveSupport::TestCase
  test "can nullify request logs on destroy" do
    pokemon = Pokemon.create!(
      name: "bulbasaur",
      external_id: 1,
      height: 7,
      weight: 69,
      types: [{ "type" => { "name" => "grass" } }]
    )

    log = RequestLog.create!(
      request_id: SecureRandom.uuid,
      http_method: "GET",
      path: "/pokemon/random",
      status: 200,
      duration_ms: 10,
      pokemon_id: pokemon.id
    )

    pokemon.destroy!

    assert_nil log.reload.pokemon_id
  end
end
