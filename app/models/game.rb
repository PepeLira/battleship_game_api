class Game < ApplicationRecord
    belongs_to :room, dependent: :destroy
    has_many :turns, dependent: :destroy
    has_one :board, dependent: :destroy
    has_one :player_room, dependent: :destroy, :as => :current_player

    after_create :create_board

    def create_board
        Board.create(game_id: id)
    end
end
