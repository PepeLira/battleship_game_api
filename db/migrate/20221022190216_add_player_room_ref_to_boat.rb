class AddPlayerRoomRefToBoat < ActiveRecord::Migration[7.0]
  def change
    add_reference(:boats, :game_player, index: true, foreign_key: { to_table: :player_rooms })
  end
end
