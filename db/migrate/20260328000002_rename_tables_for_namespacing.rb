class RenameTablesForNamespacing < ActiveRecord::Migration[7.1]
  def change
    if table_exists?(:pokemon) && !table_exists?(:pokemon_api_pokemon)
      rename_table :pokemon, :pokemon_api_pokemon
    end

    if table_exists?(:request_logs) && !table_exists?(:pokemon_api_request_logs)
      rename_table :request_logs, :pokemon_api_request_logs
    end

    rename_request_log_indexes
  end

  private

  def rename_request_log_indexes
    rename_index_if_present("index_request_logs_on_created_at", "index_pokemon_api_request_logs_on_created_at")
    rename_index_if_present("index_request_logs_on_request_id", "index_pokemon_api_request_logs_on_request_id")
    rename_index_if_present("index_request_logs_on_ip", "index_pokemon_api_request_logs_on_ip")
    rename_index_if_present("index_request_logs_on_path", "index_pokemon_api_request_logs_on_path")
    rename_index_if_present("index_request_logs_on_pokemon_id", "index_pokemon_api_request_logs_on_pokemon_id")
    rename_index_if_present(
      "index_request_logs_on_pokemon_id_and_created_at",
      "index_pokemon_api_request_logs_on_pokemon_id_and_created_at"
    )
  end

  def rename_index_if_present(old_name, new_name)
    return unless index_name_exists?(:pokemon_api_request_logs, old_name)

    rename_index :pokemon_api_request_logs, old_name, new_name
  end
end
