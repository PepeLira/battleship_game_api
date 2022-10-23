class PlayerRoom < ApplicationRecord
  belongs_to :player, dependent: :destroy
  belongs_to :room, dependent: :destroy
  has_many :boats, dependent: :destroy

  belongs_to :game, dependent: :destroy

  def suicide?(x_cord, y_cord)
    boats = Boat.where(game_player_id: id)
    suicide = false
    boats.each do |boat|
      if boat.check_impact(x_cord, y_cord)
        suicide = true
        break
      end
    end
    suicide
  end

  def player_point
    winer_turns = Turn.where(result: "impacto")
    winer_turns.length()
  end

  def player_misses
    miss_turns = Turn.where(result: "agua")
    miss_turns.length()
  end
end
