class AddBonificationToPlayerRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :player_rooms, :bonification, :boolean
  end
end
