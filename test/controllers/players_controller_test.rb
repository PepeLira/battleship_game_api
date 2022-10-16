require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get players_url
    assert_response :success
  end

  test "should get new" do
    get new_player_url
    assert_response :success
  end

  test "should create player" do
    assert_difference("Player.count") do
      post players_url, params: { player: { auth_key: @player.auth_key, email: @player.email, mean_of_misses_by_game: @player.mean_of_misses_by_game, n_bonifications: @player.n_bonifications, n_effectiveness: @player.n_effectiveness, n_lose_games: @player.n_lose_games, n_played_games: @player.n_played_games, n_win_games: @player.n_win_games, name: @player.name, turns_mean_of_games: @player.turns_mean_of_games } }
    end

    assert_redirected_to player_url(Player.last)
  end

  test "should show player" do
    get player_url(@player)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_url(@player)
    assert_response :success
  end

  test "should update player" do
    patch player_url(@player), params: { player: { auth_key: @player.auth_key, email: @player.email, mean_of_misses_by_game: @player.mean_of_misses_by_game, n_bonifications: @player.n_bonifications, n_effectiveness: @player.n_effectiveness, n_lose_games: @player.n_lose_games, n_played_games: @player.n_played_games, n_win_games: @player.n_win_games, name: @player.name, turns_mean_of_games: @player.turns_mean_of_games } }
    assert_redirected_to player_url(@player)
  end

  test "should destroy player" do
    assert_difference("Player.count", -1) do
      delete player_url(@player)
    end

    assert_redirected_to players_url
  end
end
