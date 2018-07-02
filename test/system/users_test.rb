require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a Users" do
    visit users_url
    click_on "New Users"

    click_on "Create Users"

    assert_text "Users was successfully created"
    click_on "Back"
  end

  test "updating a Users" do
    visit users_url
    click_on "Edit", match: :first

    click_on "Update Users"

    assert_text "Users was successfully updated"
    click_on "Back"
  end

  test "destroying a Users" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Users was successfully destroyed"
  end
end
