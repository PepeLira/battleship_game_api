class AddBoardRefToBoat < ActiveRecord::Migration[7.0]
  def change
    add_reference :boats, :boat, null: false, foreign_key: true
  end
end
