class Pokemon < ApplicationRecord
  self.table_name = "pokemon_api_pokemon"

  has_many :request_logs, dependent: :nullify
end
