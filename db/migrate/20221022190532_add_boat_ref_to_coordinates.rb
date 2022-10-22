class AddBoatRefToCoordinates < ActiveRecord::Migration[7.0]
  def change
    add_reference :coordinates, :boat, null: false, foreign_key: true
  end
end
