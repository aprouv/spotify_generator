# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating playlists..."

Playlist.create(name: "Playlist1", energy: "60", danceability: "65", genre: "genre1")
Playlist.create(name: "Playlist2", energy: "25", danceability: "30", genre: "genre2")
Playlist.create(name: "Playlist3", energy: "45", danceability: "40", genre: "genre3")

puts "Done !"
