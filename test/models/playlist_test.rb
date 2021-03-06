require "test_helper"

class PlaylistTest < ActiveSupport::TestCase

  setup do
    @user = users(:andrea)
  end

  def valid_playlist_params
    {
      name: 'name1',
      energy: 35,
      danceability: 56,
      genre: "rock",
      user: @user
    }
  end

  test "should validate name presence" do
    playlist = Playlist.new(valid_playlist_params.merge(name: ''))
    assert_not playlist.valid?
  end

  test "should validate that all three parameters cannot be blank" do
    playlist = Playlist.new(valid_playlist_params.merge(energy: nil, danceability: nil, genre: ""))
    assert_not playlist.valid?
  end

  test "should validate that at least one parameter is filled" do
    playlist = @user.playlists.new(valid_playlist_params.merge(genre: nil, danceability: nil))
    assert playlist.valid?
    playlist = Playlist.new(valid_playlist_params.merge(energy: nil, danceability: nil))
    assert playlist.valid?
    playlist = Playlist.new(valid_playlist_params.merge(energy: nil, genre: nil))
    assert playlist.valid?
  end

  test "should validate that genre is valid" do
    playlist = Playlist.new(valid_playlist_params.merge(genre: "folk"))
    assert playlist.valid?
    playlist = Playlist.new(valid_playlist_params.merge(genre: "genre1"))
    assert_not playlist.valid?
  end

  test "should validate that danceability is between 1 and 100" do
    i = rand(1..100)
    playlist = Playlist.new(valid_playlist_params.merge(danceability: i))
    assert playlist.valid?
  end

  test "should validate that energy is between 1 and 100" do
    i = rand(1..100)
    playlist = Playlist.new(valid_playlist_params.merge(energy: i))
    assert playlist.valid?
  end

  test "should validate that danceability is not greater than 100" do
    playlist = Playlist.new(valid_playlist_params.merge(danceability: 101))
    assert_not playlist.valid?
  end

  test "should validate that energy is not greater than 100" do
    playlist = Playlist.new(valid_playlist_params.merge(energy: 176))
    assert_not playlist.valid?
  end

  test "should validate that danceability is not less than 1" do
    playlist = Playlist.new(valid_playlist_params.merge(danceability: 0))
    assert_not playlist.valid?
  end

  test "should validate that energy is not less than 1" do
    playlist = Playlist.new(valid_playlist_params.merge(energy: -1))
    assert_not playlist.valid?
  end

  test "should validate user_id presence" do
    playlist = Playlist.new(valid_playlist_params.merge(user_id: nil))
    assert_not playlist.valid?
  end
end
