require "application_system_test_case"

class CompaniesTest < ApplicationSystemTestCase
  setup do
    @company = companies(:one)
  end

  test "visiting the index" do
    visit companies_url
    assert_selector "h1", text: "Companies"
  end

  test "creating a Companies" do
    visit companies_url
    click_on "New Companies"

    click_on "Create Companies"

    assert_text "Companies was successfully created"
    click_on "Back"
  end

  test "updating a Companies" do
    visit companies_url
    click_on "Edit", match: :first

    click_on "Update Companies"

    assert_text "Companies was successfully updated"
    click_on "Back"
  end

  test "destroying a Companies" do
    visit companies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Companies was successfully destroyed"
  end
end
