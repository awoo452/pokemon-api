class AddPokemonToRequestLogs < ActiveRecord::Migration[7.1]
  def change
    add_reference :request_logs, :pokemon, foreign_key: true
    add_index :request_logs, [:pokemon_id, :created_at]
  end
end
