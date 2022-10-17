class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    games = Game.all
    render json: games
  end

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
