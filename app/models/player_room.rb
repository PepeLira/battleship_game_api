class PlayerRoom < ApplicationRecord
  belongs_to :player, dependent: :destroy
  belongs_to :room, dependent: :destroy
end
