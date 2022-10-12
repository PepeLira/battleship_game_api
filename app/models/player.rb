class Player < ApplicationRecord
    has_many :turns, dependent: :destroy
    has_many :friend_requests, dependent: :destroy
    has_one :friend, dependent: :destroy
    belongs_to :room, dependent: :destroy
end
