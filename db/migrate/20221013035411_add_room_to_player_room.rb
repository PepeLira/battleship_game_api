class AddRoomToPlayerRoom < ActiveRecord::Migration[7.0]
  def change
    add_reference :player_rooms, :room, null: false, foreign_key: true
  end
end
