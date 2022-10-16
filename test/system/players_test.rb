require "application_system_test_case"

class PlayersTest < ApplicationSystemTestCase
  setup do
    @player = players(:one)
  end

  test "visiting the index" do
    visit players_url
    assert_selector "h1", text: "Players"
  end

  test "should create player" do
    visit players_url
    click_on "New player"

    fill_in "Auth key", with: @player.auth_key
    fill_in "Email", with: @player.email
    fill_in "Mean of misses by game", with: @player.mean_of_misses_by_game
    fill_in "N bonifications", with: @player.n_bonifications
    fill_in "N effectiveness", with: @player.n_effectiveness
    fill_in "N lose games", with: @player.n_lose_games
    fill_in "N played games", with: @player.n_played_games
    fill_in "N win games", with: @player.n_win_games
    fill_in "Name", with: @player.name
    fill_in "Turns mean of games", with: @player.turns_mean_of_games
    click_on "Create Player"

    assert_text "Player was successfully created"
    click_on "Back"
  end

  test "should update Player" do
    visit player_url(@player)
    click_on "Edit this player", match: :first

    fill_in "Auth key", with: @player.auth_key
    fill_in "Email", with: @player.email
    fill_in "Mean of misses by game", with: @player.mean_of_misses_by_game
    fill_in "N bonifications", with: @player.n_bonifications
    fill_in "N effectiveness", with: @player.n_effectiveness
    fill_in "N lose games", with: @player.n_lose_games
    fill_in "N played games", with: @player.n_played_games
    fill_in "N win games", with: @player.n_win_games
    fill_in "Name", with: @player.name
    fill_in "Turns mean of games", with: @player.turns_mean_of_games
    click_on "Update Player"

    assert_text "Player was successfully updated"
    click_on "Back"
  end

  test "should destroy Player" do
    visit player_url(@player)
    click_on "Destroy this player", match: :first

    assert_text "Player was successfully destroyed"
  end
end
