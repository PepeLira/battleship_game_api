class AddRoomRefToGame < ActiveRecord::Migration[7.0]
  def change
    add_reference :games, :room, null: false, foreign_key: true
  end
end
