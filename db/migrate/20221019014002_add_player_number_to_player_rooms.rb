class AddPlayerNumberToPlayerRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :player_rooms, :player_number, :integer
  end
end
