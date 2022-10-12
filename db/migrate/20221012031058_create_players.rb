class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :email
      t.string :auth_key
      t.integer :n_win_games
      t.integer :n_lose_games
      t.integer :n_played_games
      t.integer :n_bonifications
      t.integer :n_effectiveness
      t.integer :turns_mean_of_games
      t.integer :mean_of_misses_by_game

      t.timestamps
    end
  end
end
