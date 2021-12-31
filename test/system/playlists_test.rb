require "application_system_test_case"
require "minitest/mock"

class PlaylistsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  setup do
    @user = users(:andrea)
    login_as(@user, :scope => :user)
    @playlist = playlists(:one)
    @new_playlist = Playlist.new(name: "PlaylistTest", genre: "techno", energy: "45", danceability: "98")
  end

  test "visit index" do

    visit playlists_path

    assert_selector "h1", text: "Toutes les playlists"
    assert_selector "h3", text: "#{@playlist.name}"
  end

  test "visit show" do
    visit playlist_path(@playlist)

    assert_selector("h1", text: "#{@playlist.name.capitalize}")
    assert_selector "ul" do
      assert_selector("li", text: "Genre : #{@playlist.genre.capitalize}")
      assert_selector("li", text: "Energie")
      assert_selector("li", text: "Rythme")
    end
  end

  test "can create playlist with valid parameters (from index)" do
    visit playlists_path

    click_on "Créer une playlist"

    assert_selector("form#new_playlist")

    fill_in "Nom de la playlist", with: "#{@new_playlist.name}"
    select "#{@new_playlist.genre}", from: "Genre musical"
    select "#{@new_playlist.danceability}", from: "Niveau de rythme"
    select "#{@new_playlist.energy}", from: "Niveau d'énergie"

    playlist_creator = MiniTest::Mock.new
    playlist_creator.expect :generate_from_seeds, '7arUpiznIbygcHXRgfND8u'

    PlaylistCreator.stub :new, playlist_creator do
      click_on "Ajouter"
    end

    assert_equal Playlist.last.spotify_id, '7arUpiznIbygcHXRgfND8u'

    assert_text "#{@new_playlist.name.capitalize}"
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
