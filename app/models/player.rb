class Player < ApplicationRecord
  after_create :create_friend_association

  has_many :turns, dependent: :destroy
  has_many :friend_requests, dependent: :destroy
  has_one :friend, dependent: :destroy
  has_many :player_rooms, dependent: :destroy

  def create_friend_association
    Friend.create(player_id: id)
  end
end
