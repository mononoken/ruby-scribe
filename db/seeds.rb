# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  User.find_or_create_by(email: "iceking@fionafans.com") do |user|
    user.username = "iceking"
    user.password = "gunter"
  end

  User.find_or_create_by(email: "bmo@finncakes.com") do |user|
    user.username = "BMO"
    user.password = "football"
  end

  User.find_or_create_by(email: "finn@human.com") do |user|
    user.username = "Finn"
    user.password = "buffbaby"
  end

  User.find_or_create_by(email: "jake@human.com") do |user|
    user.username = "Jake the Dog"
    user.password = "baconpancakes"
  end

  User.find_or_create_by(email: "vampirequeen@bass.com") do |user|
    user.username = "Marceline"
    user.password = "simonp"
  end
end
