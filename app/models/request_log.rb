class RequestLog < ApplicationRecord
  belongs_to :pokemon, optional: true
end
