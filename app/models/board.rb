class Board < ApplicationRecord
    belongs_to :game, dependent: :destroy
    has_many :coordinates, dependent: :destroy
    has_many :boats, dependent: :destroy
end