class Coordinate < ApplicationRecord
    belongs_to :board, dependent: :destroy
    belongs_to :boat, dependent: :destroy

    after_update :update_boat_state


    def update_boat_state
        coords = boat.coordinates.where(state: "alive")
        if coord.length() == 0
            boat.update(state: "dead")
        end
    end

    def check_bonification
        bonificate = false
        if boat.n_of_cells == 5
            alive_coords = Coordinate.where(boat: boat, state: "alive")
            
            if alive_coords.length() == 0
                bonificate = true
            end
        end
        bonificate
    end
end
