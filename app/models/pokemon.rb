class Pokemon < ApplicationRecord
  has_many :request_logs, dependent: :nullify
end
