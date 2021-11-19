class PlaylistCreator

  def initialize(playlist)
    @playlist = playlist
  end

  def genre
    @playlist.genre
  end

  def energy
    @playlist.energy
  end

  def danceability
    @playlist.danceability
  end

  def generate_from_seeds
    user = retrieve_user
    recommendations = RSpotify::Recommendations.generate(seed_genres: [genre], target_energy: energy/100, target_danceability: danceability/100)
    tracks = recommendations.tracks
    spotify_playlist = user.create_playlist!(@playlist.name)
    spotify_playlist.add_tracks!(tracks)
    spotify_playlist.id
  end

  private

  def retrieve_user
    authenticate_on_spotify
    RSpotify::User.new(
      'id' => 'exzc2ueeacu6w6rd7x13584lx',
      'credentials' => {
        'refresh_token' => ENV["REFRESH_TOKEN"],
        'token' => ENV["TOKEN"],
        }
    )
  end

  def authenticate_on_spotify
    spotify_id = ENV["CLIENT_ID"]
    spotify_secret = ENV["CLIENT_SECRET"]
    RSpotify::authenticate(spotify_id, spotify_secret)
  end

end
