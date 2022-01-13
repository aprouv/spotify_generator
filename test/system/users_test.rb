require "application_system_test_case"
require "minitest/mock"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    OmniAuth.config.test_mode = true
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"]  = spotify_mock
  end

  test "login with valid Spotify account" do

    visit root_path

    click_on "Me connecter avec Spotify"

    assert_text "Successfully authenticated from Spotify account."
    assert_text "Toutes les playlists"
    assert_text "Déconnexion"
  end

  # test "login with valid information followed by logout" do

  #   visit root_path

  #   click_on "Me connecter avec Spotify"

  #   assert_selector("form")

  #   fill_in "Email", with: "#{@user.email}"
  #   fill_in "Password", with: "password"

  #   click_on "Log in"

  #   assert_selector("h1", text: "Toutes les playlists")
  #   assert_text "Signed in successfully."

  #   click_on "Déconnexion"
  #   assert_text "Signed out successfully."
  # end
end
