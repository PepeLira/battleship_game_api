class PlayerRoom < ApplicationRecord
  belongs_to :player, dependent: :destroy
  belongs_to :room, dependent: :destroy
  has_many :boats, dependent: :destroy
  belongs_to :game, dependent: :destroy
end
