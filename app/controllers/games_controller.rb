class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    games = Game.all
    render json: games
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
      new_game = Game.new(room: room, winner: nil, player_room_id: first_player.id)
      room.state = "in game"

      new_game.save!

    end
  end

  # Para crear una nueva sala
  def create_new_game
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
      
      if game.player_turn?(player_room)
        if suicide?( params[:x_cord], params[:y_cord] )
          response = {message: "No te dispares a ti mismo :("}
        else
          impact_coords = board.fire_result( params[:x_cord], params[:y_cord] )
          if impact_coords
            result = "impacto"
            impact_coords.update(state: "dead")
            bonification = impact_coords.check_bonification
            if bonification
              player_room.update(bonification: bonification)
            end
            response = {message: "Impacto [#{params[:x_cord].to_s},#{params[:y_cord].to_s}], vuelves a jugar"}
          else
            result = "agua"
            next_player = game.next_player_turn
            response = {message: "Al agua, le toca a #{next_player}"}
          end
          Turn.create(x_cord: params[:x_cord], y_cord: params[:y_cord], result: result, game: game, player: player_room.player)
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
        if pr.room.state == "open"
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
