
puts "Creating playlists..."

User.create(email: "test@test.com", password: "coucou")

Playlist.create(name: "Playlist1", energy: "60", danceability: "65", genre: "rock", user_id: 1)
Playlist.create(name: "Playlist2", energy: "25", danceability: "30", user_id: 1)
Playlist.create(name: "Playlist3", energy: "45", danceability: "40", user_id: 1)

puts "Done !"
