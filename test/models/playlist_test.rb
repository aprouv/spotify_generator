require "test_helper"

class PlaylistTest < ActiveSupport::TestCase

  def valid_playlist_params
    {
      name: 'name1',
      energy: 35,
      danceability: 56,
      genre: "genre1"
    }
  end

  test "should validate name presence" do
    playlist = Playlist.new(valid_playlist_params.merge(name: ''))
    assert_not playlist.valid?
  end

  test "should validate that all three parameters cannot be blank" do
    playlist = Playlist.new(valid_playlist_params.merge(energy: nil, danceability: nil, genre: ""))
    playlist.valid?
    assert_not playlist.errors[:base].empty?
  end

  test "should validate that at least one parameter is filled" do
    playlist = Playlist.new(valid_playlist_params.merge(genre: "", danceability: nil))
    playlist.valid?
    assert_empty playlist.errors[:base]
    playlist = Playlist.new(valid_playlist_params.merge(energy: nil, danceability: nil))
    playlist.valid?
    assert_empty playlist.errors[:base]
    playlist = Playlist.new(valid_playlist_params.merge(energy: nil, genre: ""))
    playlist.valid?
    assert_empty playlist.errors[:base]
  end

  test "should validate that danceability is between 1 and 100" do
    i = rand(1..100)
    playlist = Playlist.new(name: "name1", danceability: i)
    playlist.valid?
    assert_empty playlist.errors[:danceability]
  end

  test "should validate that energy is between 1 and 100" do
    i = rand(1..100)
    playlist = Playlist.new(name: "name1", energy: i)
    playlist.valid?
    assert_empty playlist.errors[:energy]
  end

  test "should validate that danceability is not greater than 100" do
    playlist = Playlist.new(valid_playlist_params.merge(danceability: 101))
    playlist.valid?
    assert_not playlist.errors[:danceability].empty?
  end

  test "should validate that energy is not greater than 100" do
    playlist = Playlist.new(valid_playlist_params.merge(energy: 176))
    playlist.valid?
    assert_not playlist.errors[:energy].empty?
  end

  test "should validate that danceability is not less than 1" do
    playlist = Playlist.new(valid_playlist_params.merge(danceability: 0))
    playlist.valid?
    assert_not playlist.errors[:danceability].empty?
  end

  test "should validate that energy is not less than 1" do
    playlist = Playlist.new(valid_playlist_params.merge(energy: -1))
    playlist.valid?
    assert_not playlist.errors[:energy].empty?
  end
end
