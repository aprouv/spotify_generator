require "test_helper"

class PlaylistsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @playlist = playlists(:one)
  end

  test "can get index" do
    get playlists_url
    assert_response :success
    assert_select "ul" do
      assert_select "li", Playlist.count
    end
  end

  test "can view playlist" do
    get playlist_url(@playlist)
    assert_response :success
    assert_select "h1", "#{@playlist.name}"
    assert_select "li", "Genre : #{@playlist.genre}"
  end

  test "can get new" do
    get new_playlist_url
    assert_response :success
  end

  test "can create a playlist" do
    assert_difference('Playlist.count') do
      post playlists_url, params: { playlist: {name: "Playlist1", energy: "60", danceability: "65", genre: "genre1"} }
    end
    assert_redirected_to playlist_url(Playlist.last)
  end

  test "cannot create a playlist with invalid name" do
    assert_no_difference('Playlist.count') do
      post playlists_url, params: { playlist: {name: "", energy: "60", danceability: "65", genre: "genre4"} }
    end
  end

  test "cannot create a playlist with invalid parameters" do
    assert_no_difference('Playlist.count') do
      post playlists_url, params: { playlist: {name: "Playlist4"} }
    end
  end
end
