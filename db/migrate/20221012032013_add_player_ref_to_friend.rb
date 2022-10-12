class AddPlayerRefToFriend < ActiveRecord::Migration[7.0]
  def change
    add_reference :friends, :player, null: false, foreign_key: true
  end
end
