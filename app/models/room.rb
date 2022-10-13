class Room < ApplicationRecord
  has_many :player_rooms, dependent: :destroy
  has_one :game, dependent: :destroy
end
