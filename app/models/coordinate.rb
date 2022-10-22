class Coordinate < ApplicationRecord
    belongs_to :room, dependent: :destroy
    belongs_to :boat, dependent: :destroy
end
