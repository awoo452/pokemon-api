require "test_helper"

class PokemonsControllerTest < ActionDispatch::IntegrationTest
  PokemonResponse = Struct.new(:parsed_response, :code)

  def with_pokemon_service_stub(total_pokemon:, fetch_pokemon:)
    original_total = PokemonService.method(:total_pokemon)
    original_fetch = PokemonService.method(:fetch_pokemon)

    PokemonService.define_singleton_method(:total_pokemon) { total_pokemon.call }
    PokemonService.define_singleton_method(:fetch_pokemon) { |id| fetch_pokemon.call(id) }

    yield
  ensure
    PokemonService.define_singleton_method(:total_pokemon, original_total)
    PokemonService.define_singleton_method(:fetch_pokemon, original_fetch)
  end

  test "random returns payload without persisting by default" do
    payload = {
      "id" => 25,
      "name" => "pikachu",
      "height" => 4,
      "weight" => 60,
      "types" => [{ "type" => { "name" => "electric" } }]
    }

    pokemon_response = PokemonResponse.new(payload, 200)
    with_pokemon_service_stub(
      total_pokemon: -> { 151 },
      fetch_pokemon: ->(_id) { pokemon_response }
    ) do
      assert_difference("RequestLog.count", 1) do
        assert_no_difference("Pokemon.count") do
          get pokemon_random_url
        end
      end
    end

    assert_response :success
    assert_equal payload, JSON.parse(response.body)
    assert_nil RequestLog.order(created_at: :desc).first.pokemon_id
  end

  test "random persists when persist is true" do
    payload = {
      "id" => 7,
      "name" => "squirtle",
      "height" => 5,
      "weight" => 90,
      "types" => [{ "type" => { "name" => "water" } }]
    }

    pokemon_response = PokemonResponse.new(payload, 200)
    with_pokemon_service_stub(
      total_pokemon: -> { 151 },
      fetch_pokemon: ->(_id) { pokemon_response }
    ) do
      assert_difference("RequestLog.count", 1) do
        assert_difference("Pokemon.count", 1) do
          get pokemon_random_url(persist: "true")
        end
      end
    end

    assert_response :success
    log = RequestLog.order(created_at: :desc).first
    assert_equal Pokemon.last.id, log.pokemon_id
  end

  test "original range does not call total_pokemon" do
    payload = {
      "id" => 1,
      "name" => "bulbasaur",
      "height" => 7,
      "weight" => 69,
      "types" => [{ "type" => { "name" => "grass" } }]
    }

    pokemon_response = PokemonResponse.new(payload, 200)
    with_pokemon_service_stub(
      total_pokemon: -> { raise "total_pokemon should not be called" },
      fetch_pokemon: ->(_id) { pokemon_response }
    ) do
      get pokemon_random_url(range: "original", persist: "false")
    end

    assert_response :success
  end
end
