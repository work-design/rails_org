require "application_system_test_case"

class ResignsTest < ApplicationSystemTestCase
  setup do
    @resign = resigns(:one)
  end

  test "visiting the index" do
    visit resigns_url
    assert_selector "h1", text: "Resigns"
  end

  test "creating a Resign" do
    visit resigns_url
    click_on "New Resign"

    click_on "Create Resign"

    assert_text "Resign was successfully created"
    click_on "Back"
  end

  test "updating a Resign" do
    visit resigns_url
    click_on "Edit", match: :first

    click_on "Update Resign"

    assert_text "Resign was successfully updated"
    click_on "Back"
  end

  test "destroying a Resign" do
    visit resigns_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Resign was successfully destroyed"
  end
end
