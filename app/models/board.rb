class Board < ApplicationRecord
    belongs_to :game, dependent: :destroy
    has_many :coordinates, dependent: :destroy
    has_many :boats, dependent: :destroy

    after_create :create_boats
    before_create :init_board

    def init_board
        @predef_board = { 
            "boat_2" => [[[2,2],[3,2]], [[1,6],[2,6]], [[3,10],[4,10]], [[2,13],[3,13]], [[2,18],[3,18]] ],
            "boat_3" => [[[5,2],[6,2],[7,2]], [[3,15],[4,15],[5,15]], [[2,4],[3,4],[4,4]], [[2,14],[2,15],[2,16]], [[4,6],[4,7],[4,8]] ],
            "boat_5" => [[[2,8],[2,9],[2,10],[2,11],[2,12]], [[6,4],[6,5],[6,6],[6,7],[6,8]], [[8,4],[8,5],[8,6],[8,7],[8,8]], [[5,9],[5,10],[5,11],[5,12],[5,13]], [[3,17],[4,17],[5,17],[6,17],[7,17]] ]
        }
    end

    def next_player_turn
        while true
            current_player = PlayerRoom.find_by(player_number: game.current_player_number + 1, room_id: game.room_id, state: nil)
            game.update(current_player_number: game.current_player_number + 1)
            if current_player
                break
            elsif game.current_player_number >= 5
                game.update(current_player_number: 0)
            end
        end
        current_player.player
    end

    def create_boats
        players = PlayerRoom.where(room_id: self.game.room_id)
        

        players.each do |player|
            boat_2 = Boat.new(state: "alive", n_of_cells: 2, player_room: player, board_id: id)
            boat_2.save
            boat_2.set_coordinates(get_rand_boat("boat_2"))
            boat_3 = Boat.new(state: "alive", n_of_cells: 3, player_room: player, board_id: id)
            boat_3.save
            boat_3.set_coordinates(get_rand_boat("boat_3"))
            boat_5 = Boat.new(state: "alive", n_of_cells: 5, player_room: player, board_id: id)
            boat_5.save
            boat_5.set_coordinates(get_rand_boat("boat_5"))
        end

    end

    def get_rand_boat(key)
        @predef_board[key].delete_at(rand(@predef_board[key].length))
    end

    def fire_result(x_cord, y_cord)
        coordinates = Coordinate.where(board_id: id, state: "alive")
        impact = nil
        coordinates.each do |coord|
            if coord.x == x_cord && coord.y == y_cord
                impact = coord
            end
        end
        impact
    end
end