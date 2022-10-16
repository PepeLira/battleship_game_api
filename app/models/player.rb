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
end
