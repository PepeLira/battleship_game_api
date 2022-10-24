class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    games = Game.all
    render json: games
  end

  def get_all_rooms
    render json: Room.all
  end

  def get_game_state
    if params[:room_id]
      room = Room.find(params[:room_id])
      game = Game.find_by(room_id: params[:room_id])
      alive_coordinates = Coordinate.where(board_id: Board.find_by(game: game).id, state: "alive")

      if alive_coordinates.length() == 0
        room.update(state: "closed")
        room.update_player_stats
        game.update(winner: room.get_winner)
        render json: "finished"
      else
        render json: "game_in_progress"
      end
    end
  end

  def get_board_state
    if params[:room_id] && params[:player_id]

      player_room = PlayerRoom.where(player_id: params[:player_id], room_id: params[:room_id]).first

      data = {'alive': [], 'dead': []}
      
      # Buildeo del json
      for boat in player_room.boats
        for coord in boat.coordinates
          if coord.state == "alive"
            data[:alive] << coord
          else
            data[:dead] << coord
          end
        end
      end
      render json: data
    end
  end

  #POST NEW GAME
  def new_game
    if params[:room_id].present?
      room = Room.find_by(id: params[:room_id])

      count = 1
      first_player = nil
      # Asignación de los players 
      PlayerRoom.where(room_id: params[:room_id]).each do |pr|
        if count == 1
          first_player = pr
        end
        pr.update(player_number: count)
        count += 1
      end

      # Instancia del nuevo juego (player_room es current_player)
      if !Game.find_by(room: room)
        new_game = Game.new(room: room, winner: nil, current_player_number: first_player.player_number)
        room.update(state: "in game")

        new_game.save!
      end
    end
  end

  def get_current_player_turn
    if params[:room_id].present?
      game = Game.find_by(room_id: params[:room_id])
      render json: "Player_#{game.current_player_number.to_s}"
    end
  end

  # Para crear una nueva sala
  def create_new_room
    if params[:player_id].present?
      room = Room.new(state: "open")
      room.save!
      player = Player.find_by(id: params[:player_id])
      player_room = PlayerRoom.new(player: player, room: room, status: "accepted")
      player_room.save!
      render json: room
    end
  end

  def post_new_turn
    if params[:x_cord].present? && params[:y_cord].present? && params[:player_id].present? && params[:room_id].present?
      response = {}
      player_room = PlayerRoom.find_by(player_id: params[:player_id], room_id: params[:room_id])
      game = Game.find_by(room_id: params[:room_id])
      board = Board.find_by(game: game)
      if game.player_turn?(player_room.player_number)
        if player_room.suicide?( params[:x_cord].to_i, params[:y_cord].to_i )
          response = {message: "No te dispares a ti mismo :("}
        else
          impact_coords = board.fire_result( params[:x_cord].to_i, params[:y_cord].to_i )
          if impact_coords
            result = "impacto"
            impact_coords.update(state: "dead")
            bonification = impact_coords.check_bonification
            if bonification
              player_room.update(bonification: bonification)
              player_room.player.update_n_bonifications
            end
            response = {message: "Impacto [#{params[:x_cord]},#{params[:y_cord]}], vuelves a jugar"}
          else
            result = "agua"
            next_player = game.next_player_turn
            response = {message: "Al agua, le toca al jugador #{next_player.player_number} (#{next_player.name})"}
          end
          Turn.create(x_cord: params[:x_cord].to_i, y_cord: params[:y_cord].to_i, result: result, game: game, player: player_room.player)
        end
      else
        response = {message: "Actualmente no es tu turno :("}
      end

      render json: response

    end
  end


  def add_new_player
    if params[:room_id].present? && params[:player_id].present?
      room = Room.find_by(id: params[:room_id])
      player = Player.find_by(id: params[:player_id])
      player_room = PlayerRoom.new(player: player, room: room, status: "pending")
      player_room.save!
      render json: room
    end
  end

  def get_rooms
    if params[:status].present? && params[:player_id].present?
      player_rooms = PlayerRoom.where(player_id: params[:player_id], status: params[:status])

      rooms = []

      player_rooms.each do |pr|
        if pr.room.state == "open" || pr.room.state == "in game"
          rooms << pr.room
        end
      end

      render json: rooms
    end
  end

  def get_room_players
    if params[:room_id].present?
      player_rooms = PlayerRoom.where(room_id: params[:room_id], status: "accepted")

      players = []

      player_rooms.each do |pr|
        players << pr.player
      end

      render json: players
    end
  end

  def respond_invitation
    if params[:room_id].present? && params[:player_id].present? && params[:status].present?
      player_room = PlayerRoom.where(room_id: params[:room_id], player_id: params[:player_id], status: "pending").first

      action_player_room = player_room.update(status: params[:status])

      render json: action_player_room
    end
  end
end
