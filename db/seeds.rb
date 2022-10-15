# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

Player.destroy_all
FriendRequest.destroy_all

player_1 = Player.new(
    name: "pepe",
    email: "pepe@pepe.com",
    password: "1234",
    n_win_games: 0,
    n_lose_games: 0,
    n_played_games: 0,
    n_bonifications: 0,
    n_effectiveness: 0,
    turns_mean_of_games: 0,
    mean_of_misses_by_game: 0)
player_1.save!

player_2 = Player.new(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: "1234",
    n_win_games: 0,
    n_lose_games: 0,
    n_played_games: 0,
    n_bonifications: 0,
    n_effectiveness: 0,
    turns_mean_of_games: 0,
    mean_of_misses_by_game: 0)
player_2.save!

player_3 = Player.new(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: "1234",
    n_win_games: 0,
    n_lose_games: 0,
    n_played_games: 0,
    n_bonifications: 0,
    n_effectiveness: 0,
    turns_mean_of_games: 0,
    mean_of_misses_by_game: 0)
player_3.save!

player_4 = Player.new(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: "1234",
    n_win_games: 0,
    n_lose_games: 0,
    n_played_games: 0,
    n_bonifications: 0,
    n_effectiveness: 0,
    turns_mean_of_games: 0,
    mean_of_misses_by_game: 0)
player_4.save!

friend_request_1 = FriendRequest.new(player: player_2, friend: player_1.friend, status: "accepted")
friend_request_1.save!
friend_request_2 = FriendRequest.new(player: player_1, friend: player_3.friend, status: "pending")
friend_request_2.save!
friend_request_3 = FriendRequest.new(player: player_1, friend: player_4.friend, status: "rejected")
friend_request_3.save!
