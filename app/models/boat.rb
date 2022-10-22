class Boat < ApplicationRecord
    belongs_to :player_room, dependent: :destroy
    belongs_to :room, dependent: :destroy
    has_many :coordinates, dependent: :destroy
end
