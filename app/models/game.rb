class Game < ApplicationRecord
    belongs_to :room, dependent: :destroy
    has_many :turns, dependent: :destroy
    has_one :board, dependent: :destroy
    #alias_attribute :current_player, :player_room
        
    after_create :create_board

    def create_board
        Board.create(game_id: self.id)
    end

    def set_first_player
        Game.find(self.id).update(current_player_number: 1)
    end

    def next_player_turn
        current_player = PlayerRoom.find_by(player_number: self.current_player_number + 1)
        Game.find(self.id).update(current_player_number: self.current_player_number + 1)
        if !current_player
            Game.find(self.id).update(current_player_number: 1)
            current_player = PlayerRoom.find_by(player_number: 1)
        end
        current_player.player
    end

    
    def player_turn?(turn_player_number)
        if self.current_player_number == turn_player_number
            true
        else
            false
        end
    end
end
