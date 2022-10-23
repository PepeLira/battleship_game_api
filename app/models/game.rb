class Game < ApplicationRecord
    belongs_to :room, dependent: :destroy
    has_many :turns, dependent: :destroy
    has_one :board, dependent: :destroy
    has_one :player_room, dependent: :destroy
    #alias_attribute :current_player, :player_room
    
    after_create :create_board
    after_create :set_first_player

    def create_board
        Board.create(game_id: id)
    end

    def set_first_player
        current_player = PlayerRoom.find_by(room: room, player_number: 1)
    end

    def next_player_turn
        current_player = PlayerRoom.find_by(player_number: current_player.player_number + 1)
        if !current_player
            current_player = PlayerRoom.find_by(player_number: 1)
        end
        current_player.player.name
    end

    
    def player_turn?(turn_player)
        if player_room == turn_player
            true
        else
            false
        end
    end
end
