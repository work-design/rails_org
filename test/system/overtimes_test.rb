require "application_system_test_case"

class OvertimesTest < ApplicationSystemTestCase
  setup do
    @overtime = overtimes(:one)
  end

  test "visiting the index" do
    visit overtimes_url
    assert_selector "h1", text: "Overtimes"
  end

  test "creating a Overtime" do
    visit overtimes_url
    click_on "New Overtime"

    click_on "Create Overtime"

    assert_text "Overtime was successfully created"
    click_on "Back"
  end

  test "updating a Overtime" do
    visit overtimes_url
    click_on "Edit", match: :first

    click_on "Update Overtime"

    assert_text "Overtime was successfully updated"
    click_on "Back"
  end

  test "destroying a Overtime" do
    visit overtimes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Overtime was successfully destroyed"
  end
end
