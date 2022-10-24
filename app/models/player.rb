require 'securerandom'
class Player < ApplicationRecord
  before_create :asign_auth_key
  after_create :create_friend_association

  has_many :turns, dependent: :destroy
  has_many :friend_requests, dependent: :destroy
  has_one :friend, dependent: :destroy
  has_many :player_rooms, dependent: :destroy

  validates :email, uniqueness: true

  def create_friend_association
    Friend.create(player_id: id)
  end

  def asign_auth_key
    self.auth_key ||= SecureRandom.hex
  end

  def update_n_win_games
    Player.find(id).update(n_win_games: n_win_games+1)
  end

  def update_n_lose_games
    Player.find(id).update(n_lose_games: n_lose_games+1)
  end

  def update_n_played_games
    Player.find(id).update(n_played_games: n_played_games+1)
  end

  def update_n_bonifications
    Player.find(id).update(n_bonifications: n_bonifications+1)
  end

  def update_n_effectiveness
    turns = Turn.where(player_id: id, game_id: pr.room.game.id, result: "impacto")
    Player.find(id).update(n_effectiveness: turns.length())
  end

  def update_turns_mean_of_games
    player_rooms = PlayerRoom.where(player_id: id)
    turns = Turn.where(player_id: id, game_id: pr.room.game.id )
    mean = 0
    if player_rooms.length() != 0
      mean = turns.length()/player_rooms.length()
    end
    Player.find(id).update(turns_mean_of_games: mean)
  end

  def update_mean_of_misses_by_game
    player_rooms = PlayerRoom.where(player_id: id)
    turns = Turn.where(player_id: id, game_id: pr.room.game.id, result: "agua" )
    mean = 0
    if player_rooms.length() != 0
      mean = turns.length()/player_rooms.length()
    end
    Player.find(id).update(turns_mean_of_games: mean)
  end

end
