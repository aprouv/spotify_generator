
puts "Creating playlists..."

user = User.create(email: "test@test.com", password: "coucou")

user.playlists.create(name: "Playlist1", energy: "60", danceability: "65", genre: "rock")
user.playlists.create(name: "Playlist2", energy: "25", danceability: "30")
user.playlists.create(name: "Playlist3", energy: "45", danceability: "40")

puts "Done !"
