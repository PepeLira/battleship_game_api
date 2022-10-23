class AddCurrentPlayerToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :current_player_number, :integer
  end
end
