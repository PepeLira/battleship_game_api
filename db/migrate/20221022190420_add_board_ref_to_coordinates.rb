class AddBoardRefToCoordinates < ActiveRecord::Migration[7.0]
  def change
    add_reference :coordinates, :board, null: false, foreign_key: true
  end
end
