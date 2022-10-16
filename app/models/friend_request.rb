class FriendRequest < ApplicationRecord
    belongs_to :player, dependent: :destroy
    belongs_to :friend, dependent: :destroy
end
