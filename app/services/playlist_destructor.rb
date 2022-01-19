class PlaylistDestructor < AbstractPlaylistProvider
  def perform
    user = retrieve_provider_user
    playlist = RSpotify::Playlist.find(@playlist.user.uid, @playlist.spotify_id)
    user.unfollow(playlist)
  end
end
