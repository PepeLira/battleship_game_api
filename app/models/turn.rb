class Turn < ApplicationRecord
    belongs_to :player, dependent: :destroy
    belongs_to :game, dependent: :destroy
end
