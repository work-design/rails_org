require "application_system_test_case"

class AbsencesTest < ApplicationSystemTestCase
  setup do
    @absence = absences(:one)
  end

  test "visiting the index" do
    visit absences_url
    assert_selector "h1", text: "Absences"
  end

  test "creating a Absence" do
    visit absences_url
    click_on "New Absence"

    click_on "Create Absence"

    assert_text "Absence was successfully created"
    click_on "Back"
  end

  test "updating a Absence" do
    visit absences_url
    click_on "Edit", match: :first

    click_on "Update Absence"

    assert_text "Absence was successfully updated"
    click_on "Back"
  end

  test "destroying a Absence" do
    visit absences_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Absence was successfully destroyed"
  end
end
