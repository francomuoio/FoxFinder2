require "application_system_test_case"

class NegociatorsTest < ApplicationSystemTestCase
  setup do
    @negociator = negociators(:one)
  end

  test "visiting the index" do
    visit negociators_url
    assert_selector "h1", text: "Negociators"
  end

  test "creating a Negociator" do
    visit negociators_url
    click_on "New Negociator"

    click_on "Create Negociator"

    assert_text "Negociator was successfully created"
    click_on "Back"
  end

  test "updating a Negociator" do
    visit negociators_url
    click_on "Edit", match: :first

    click_on "Update Negociator"

    assert_text "Negociator was successfully updated"
    click_on "Back"
  end

  test "destroying a Negociator" do
    visit negociators_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Negociator was successfully destroyed"
  end
end
