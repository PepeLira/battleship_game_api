class AddPlayerRoomRefToBoat < ActiveRecord::Migration[7.0]
  def change
    add_reference :boats, :player_room, null: false, foreign_key: true
  end
end
