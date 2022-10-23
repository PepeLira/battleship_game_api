class Coordinate < ApplicationRecord
    belongs_to :board, dependent: :destroy
    belongs_to :boat, dependent: :destroy

    def check_bonification
        alive_coords = Coordinate.where(boat: boat, status: "alive")
        bonificate = false
        if alive_coords.length() == 0
            bonificate = true
        end
        bonificate
    end
end
