class Friend < ApplicationRecord
    belongs_to :player, dependent: :destroy
    has_many :friend_requests, dependent: :destroy 
end
