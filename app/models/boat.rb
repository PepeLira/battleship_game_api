class Boat < ApplicationRecord
    belongs_to :player_room, dependent: :destroy
    belongs_to :board, dependent: :destroy
    has_many :coordinates, dependent: :destroy


    def set_coordinates(coords)
        coords.each do |c|
            Coordinate.create(state: "alive", x: c[0], y: c[1], board_id: board_id, boat_id: id)
        end
    end

    def check_impact(x_cord, y_cord)
    
        boat_coords = Coordinate.where(boat_id: id)

        impact = false
        boat_coords.each do |coord|
            if coord.x == x_cord.to_i && coord.y == y_cord.to_i
                impact = true
                break
            end
        end
        impact
    end
end
