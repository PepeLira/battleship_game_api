class ChangeForeignKeyForGame < ActiveRecord::Migration[7.0]
  def change
    rename_column :games, :winner_id, :winner
  end
end
