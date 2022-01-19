class PlaylistCreator < AbstractPlaylistProvider

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
    user = retrieve_provider_user
    recommendations = RSpotify::Recommendations.generate(spotify_recommendations_params)
    tracks = recommendations.tracks
    @spotify_playlist = user.create_playlist!(@playlist.name)
    @spotify_playlist.add_tracks!(tracks)
    @spotify_playlist.id
  end

  private

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
