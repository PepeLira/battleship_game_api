class Boat < ApplicationRecord
    belongs_to :player_room, dependent: :destroy
    belongs_to :room, dependent: :destroy
    has_many :coordinates, dependent: :destroy

    def set_coordinates(coords)
        coords.each do |c|
            Coordinate.create(state: "alive", x: c[0], y: c[1], board_id: board_id, boat_id: id)
        end
    end
end
