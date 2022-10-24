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
    binding.pry
    winner_player.player_number
  end
end
