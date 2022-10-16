class AddPlayerRefToTurn < ActiveRecord::Migration[7.0]
  def change
    add_reference :turns, :player, null: false, foreign_key: true
  end
end
