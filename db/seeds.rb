
puts "Creating playlists..."

Playlist.create(name: "Playlist1", energy: "60", danceability: "65", genre: "rock")
Playlist.create(name: "Playlist2", energy: "25", danceability: "30", genre: "pop")
Playlist.create(name: "Playlist3", energy: "45", danceability: "40", genre: "acoustic")

puts "Done !"
