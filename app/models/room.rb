class Room < ApplicationRecord
  has_many :player_rooms, dependent: :destroy
  has_one :game, dependent: :destroy

  def get_winner
    players = PlayerRoom.where(room_id: id)
    max_points = 0
    winner_player = nil
    players.each do |player|
      points = player.player_point
      if points >= max_points
        winner_player = player
        max_points = points
      end
    end
    winner_player.player.update_n_win_games
    update_player_lose_stat(winner_player)
    winner_player.player_number
  end

  def update_player_lose_stat(winner)
    players = PlayerRoom.where(room_id: id)
    players.each do |p|
      if p != winner
        p.player.update_n_lose_games
      end
    end
  end

  def update_player_stats
    player_rooms = PlayerRoom.where(room_id: id)
    player_rooms.each do |player_room|
      player = Player.find(player_room.player_id)
      player.update_n_played_games
      player.update_n_effectiveness(player_room)
      player.update_turns_mean_of_games(player_room)
      player.update_mean_of_misses_by_game(player_room)
    end
  end
end
