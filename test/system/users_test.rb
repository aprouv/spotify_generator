require "application_system_test_case"
require "minitest/mock"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:andrea)
  end

  test "login with valid email/invalid password" do

    visit root_path

    click_on "Me connecter"

    assert_selector("form")

    fill_in "Email", with: "#{@user.email}"
    fill_in "Password", with: ""

    click_on "Log in"

    assert_selector("form")
    assert_text "Invalid Email or password."
  end

  test "login with invalid information" do

    visit root_path

    click_on "Me connecter"

    assert_selector("form")

    fill_in "Email", with: "aaaaa@"
    fill_in "Password", with: ""

    click_on "Log in"

    assert_selector("form")
    assert_text "Invalid Email or password."
  end

  test "login with valid information followed by logout" do

    visit root_path

    click_on "Me connecter"

    assert_selector("form")

    fill_in "Email", with: "#{@user.email}"
    fill_in "Password", with: "password"

    click_on "Log in"

    assert_selector("h1", text: "Toutes les playlists")
    assert_text "Signed in successfully."

    click_on "Déconnexion"
    assert_text "Signed out successfully."
  end

  test "sign up with valid information" do

    visit root_path

    click_on "Me connecter"

    click_on "Sign up"

    assert_selector("form")

    fill_in "Email", with: "test3@test.com"
    fill_in("Password", match: :first, with: "password")
    fill_in("Password confirmation", with: "password")

    click_on "Sign up"

    assert_selector("h1", text: "Toutes les playlists")
    assert_text "Welcome! You have signed up successfully."
  end
end
