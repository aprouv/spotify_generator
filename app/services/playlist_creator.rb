class PlaylistCreator

  def initialize(playlist)
    @playlist = playlist
  end

  def genre
    @playlist.genre
  end

  def energy
    @playlist.energy/100 if @playlist.energy.present?
  end

  def danceability
    @playlist.danceability/100 if @playlist.dancceability.present?
  end

  def generate_from_seeds
    user = retrieve_user
    recommendations = RSpotify::Recommendations.generate(spotify_recommendations_params)
    tracks = recommendations.tracks
    @spotify_playlist = user.create_playlist!(@playlist.name)
    @spotify_playlist.add_tracks!(tracks)
    @spotify_playlist.id
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

  def spotify_recommendations_params
    {
      seed_genres: seed_genre,
      target_energy: energy,
    }.compact
  end

  def seed_genre
    return [genre] if genre.present?
  end
end
