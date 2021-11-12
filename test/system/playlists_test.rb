require "application_system_test_case"

class PlaylistsTest < ApplicationSystemTestCase

  setup do
    @playlist = playlists(:one)
  end

  test "visit index" do
    visit playlists_path
    assert_selector "h1", text: "Toutes les playlists"
    assert_selector "li", text: "#{@playlist.name}"
  end

  test "visit show" do
    visit playlist_path(@playlist)
    assert_selector "h1", text: "#{@playlist.name}"
  end

  test "can create playlist (from index)" do
    visit playlists_path

    click_on "Ajouter une nouvelle playlist"

    assert_text "Ajouter une nouvelle playlist"

    fill_in "Nom de la playlist", with: "#{@playlist.name}"
    select "#{@playlist.genre}", from: "Genre musical"
    select "#{@playlist.danceability}", from: "Niveau de rythme"
    select "#{@playlist.energy}", from: "Niveau d'énergie"

    click_on "Ajouter"

    assert_text "#{@playlist.name}"
  end
end
