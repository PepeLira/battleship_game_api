json.extract! player, :id, :name, :email, :auth_key, :n_win_games, :n_lose_games, :n_played_games, :n_bonifications, :n_effectiveness, :turns_mean_of_games, :mean_of_misses_by_game, :created_at, :updated_at
json.url player_url(player, format: :json)
