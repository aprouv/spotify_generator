require "test_helper"

class PlaylistTest < ActiveSupport::TestCase
  test "invalid if name is blank" do
    playlist = Playlist.new(name: "", energy: 35, danceability: 56, genre: "genre1")
    playlist.valid?
    assert_not playlist.errors[:name].empty?
  end

  test "invalid if all parameters are blank" do
    playlist = Playlist.new(name: "name1")
    playlist.valid?
    assert_not playlist.errors[:base].empty?
  end

  test "valid if at least one parameter is filled" do
    playlist = Playlist.new(name: "name1", energy: 68)
    playlist.valid?
    assert_empty playlist.errors[:base]
  end

  test "valid if danceability & energy are between 1 and 100" do
    1.upto(100).each do |i|
      playlist = Playlist.new(name: "name1", danceability: i, energy: i)
      playlist.valid?
      assert_empty playlist.errors[:danceability]
      assert_empty playlist.errors[:energy]
    end
  end

  test "invalid if danceability & energy are greater than 100" do
    playlist = Playlist.new(name: "name1", danceability: 176, energy: 101)
    playlist.valid?
    assert_not playlist.errors[:danceability].empty?
    assert_not playlist.errors[:energy].empty?
  end

  test "invalid if danceability & energy are less than 1" do
    playlist = Playlist.new(name: "name1", danceability: -1, energy: 0)
    playlist.valid?
    assert_not playlist.errors[:danceability].empty?
    assert_not playlist.errors[:energy].empty?
  end
end
