class CreatePlayerRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :player_rooms do |t|

      t.timestamps
    end
  end
end
