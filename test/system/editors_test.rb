require "application_system_test_case"

class EditorsTest < ApplicationSystemTestCase
  setup do
    @editor = editors(:one)
  end

  test "visiting the index" do
    visit editors_url
    assert_selector "h1", text: "Editors"
  end

  test "creating a Editor" do
    visit editors_url
    click_on "New Editor"

    click_on "Create Editor"

    assert_text "Editor was successfully created"
    click_on "Back"
  end

  test "updating a Editor" do
    visit editors_url
    click_on "Edit", match: :first

    click_on "Update Editor"

    assert_text "Editor was successfully updated"
    click_on "Back"
  end

  test "destroying a Editor" do
    visit editors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Editor was successfully destroyed"
  end
end
