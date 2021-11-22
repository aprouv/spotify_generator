require "application_system_test_case"
require "minitest/mock"

class PlaylistsTest < ApplicationSystemTestCase

  setup do
    @playlist = playlists(:one)
    @new_playlist = Playlist.new(name: "PlaylistTest", genre: "techno", energy: "45", danceability: "98")
  end

  test "visit index" do
    visit playlists_path
    assert_selector "h1", text: "Toutes les playlists"
    assert_selector "ul" do
      assert_selector("li", text: "#{@playlist.name}")
    end
  end

  test "visit show" do
    visit playlist_path(@playlist)
    assert_selector("h1", text: "#{@playlist.name}")
    assert_selector("li", text: "Genre : #{@playlist.genre}")
  end

  test "can create playlist with valid parameters (from index)" do
    visit playlists_path

    click_on "Ajouter une nouvelle playlist"

    assert_selector("form#new_playlist")

    fill_in "Nom de la playlist", with: "#{@new_playlist.name}"
    select "#{@new_playlist.genre}", from: "Genre musical"
    select "#{@new_playlist.danceability}", from: "Niveau de rythme"
    select "#{@new_playlist.energy}", from: "Niveau d'énergie"

    click_on "Ajouter"

    mock = Minitest::Mock.new
    mock.expect(:generate_from_seeds, '7arUpiznIbygcHXRgfND8u')

    PlaylistCreator.stub :new, mock do
      @new_playlist.spotify_id = PlaylistCreator.new(@new_playlist).generate_from_seeds
    end

    assert_mock mock

    assert_text "#{@new_playlist.name}"
    assert_link "Ecouter"
    # click_on "Ecouter"
    # assert_text "https://open.spotify.com/playlist/#{@new_playlist.spotify_id}"
  end

  test "cannot create playlist with invalid parameters" do
    visit new_playlist_path

    assert_selector("form#new_playlist")

    fill_in "Nom de la playlist", with: ""
    select "#{@new_playlist.genre}", from: "Genre musical"
    select "#{@new_playlist.danceability}", from: "Niveau de rythme"
    select "#{@new_playlist.energy}", from: "Niveau d'énergie"

    click_on "Ajouter"

    assert_selector "form#new_playlist"
    assert_text "Name can't be blank"
  end
end
