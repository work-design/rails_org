require "application_system_test_case"

class OfficesTest < ApplicationSystemTestCase
  setup do
    @office = offices(:one)
  end

  test "visiting the index" do
    visit offices_url
    assert_selector "h1", text: "Offices"
  end

  test "creating a Office" do
    visit offices_url
    click_on "New Office"

    click_on "Create Office"

    assert_text "Office was successfully created"
    click_on "Back"
  end

  test "updating a Office" do
    visit offices_url
    click_on "Edit", match: :first

    click_on "Update Office"

    assert_text "Office was successfully updated"
    click_on "Back"
  end

  test "destroying a Office" do
    visit offices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Office was successfully destroyed"
  end
end
