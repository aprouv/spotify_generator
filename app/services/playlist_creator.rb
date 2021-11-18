class PlaylistCreator

  def initialize(genre, energy, danceability, playlist)
    @genre = genre
    @energy = energy
    @danceability = danceability
    @playlist = playlist
  end

  def authenticate_user
    spotify_id = ENV["CLIENT_ID"]
    spotify_secret = ENV["CLIENT_SECRET"]
    RSpotify::authenticate(spotify_id, spotify_secret)
    @user = RSpotify::User.new(
      'id' => 'exzc2ueeacu6w6rd7x13584lx',
      'credentials' => {
        'expires' => true,
        'expires_at' => 1637144447,
        'refresh_token' => 'AQCKo2Zs-VHm5yKF6OeOdHo8jSvTH5KgvGAifknzb1RybyFvDDHOKYFIivMB-bsI0j3gkXUbmvaV0AYS1Chvh4R1Z255ECpNqs1nTdj3MWBceOCkbX_n8JQUu0-a9iHvTlo',
        'token' => 'BQCQPaLzGey3g1Z-In_cH-sJ-ajP_LaczlJIA5Nypeel-eGWqUiBMZCDZqpqHfZNY6_WBhjGNLKrZGz1oIHvWW2pKJ23CO07umXMQ2BdvxZ9IIx6-OERqZ3WdxsL-DOsVYHuyqa6v7A9oOf402BTMt1Y4g9EmqxL8gAf4d3gqenHXj-zTeFrhV4UrE4ETcdkUF26LScpBAYxcvRYcTzavokSVw',
        }
      )
  end

  def get_playlist
    authenticate_user
    recommendations = RSpotify::Recommendations.generate(seed_genres: [@genre], target_energy: @energy/100, target_danceability: @danceability/100)
    tracks = recommendations.tracks
    spotify_playlist = @user.create_playlist!(@playlist.name)
    spotify_playlist.add_tracks!(tracks)
    @playlist.spotify_id = spotify_playlist.id
  end

end
