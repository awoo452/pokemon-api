class RequestLog < ApplicationRecord
  self.table_name = "pokemon_api_request_logs"

  belongs_to :pokemon, optional: true
end
