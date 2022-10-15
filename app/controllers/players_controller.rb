class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show ]

  # GET /players/1 or /players/1.json
  def index
    players = Player.all
    render json: players
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:name, :email, :auth_key, :n_win_games, :n_lose_games, :n_played_games, :n_bonifications, :n_effectiveness, :turns_mean_of_games, :mean_of_misses_by_game)
    end
end
