class AddStatusToPlayerRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :player_rooms, :status, :string
  end
end
