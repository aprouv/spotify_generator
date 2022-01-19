class AbstractPlaylistProvider
  attr_reader :playlist

  def initialize(playlist)
    @playlist = playlist
  end

  def user
    @playlist.user
  end

  def retrieve_provider_user
    authenticate_on_spotify
    RSpotify::User.new(
      'id' => user.uid,
      'credentials' => {
        'refresh_token' => user.refresh_token,
        'token' => user.token,
      }
    )
  end

  def authenticate_on_spotify
    spotify_id = ENV["CLIENT_ID"]
    spotify_secret = ENV["CLIENT_SECRET"]
    RSpotify::authenticate(spotify_id, spotify_secret)
  end

end
