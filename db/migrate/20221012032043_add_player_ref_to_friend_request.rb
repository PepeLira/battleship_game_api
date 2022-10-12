class AddPlayerRefToFriendRequest < ActiveRecord::Migration[7.0]
  def change
    add_reference :friend_requests, :player, null: false, foreign_key: true
  end
end
