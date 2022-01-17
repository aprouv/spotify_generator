class PlaylistDestructor

  def initialize(playlist)
    @playlist = playlist
  end

  def delete_playlist
    user = retrieve_user
    playlist = RSpotify::Playlist.find(@playlist.user.uid, @playlist.spotify_id)
    user.unfollow(playlist)
  end

  private

  def retrieve_user
    authenticate_on_spotify
    RSpotify::User.new(
      'id' => @playlist.user.uid,
      'credentials' => {
        'refresh_token' => @playlist.user.refresh_token,
        'token' => @playlist.user.token,
        }
    )
  end

  def authenticate_on_spotify
    spotify_id = ENV["CLIENT_ID"]
    spotify_secret = ENV["CLIENT_SECRET"]
    RSpotify::authenticate(spotify_id, spotify_secret)
  end
end
