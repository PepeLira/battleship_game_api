class AddStateToPlayerRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :player_rooms, :state, :string
  end
end
