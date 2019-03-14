require "application_system_test_case"

class AbsenceStatsTest < ApplicationSystemTestCase
  setup do
    @hr_absence_stat = panel_absence_stats(:one)
  end

  test "visiting the index" do
    visit panel_absence_stats_url
    assert_selector "h1", text: "Absence Stats"
  end

  test "creating a Absence stat" do
    visit panel_absence_stats_url
    click_on "New Absence Stat"

    click_on "Create Absence stat"

    assert_text "Absence stat was successfully created"
    click_on "Back"
  end

  test "updating a Absence stat" do
    visit panel_absence_stats_url
    click_on "Edit", match: :first

    click_on "Update Absence stat"

    assert_text "Absence stat was successfully updated"
    click_on "Back"
  end

  test "destroying a Absence stat" do
    visit panel_absence_stats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Absence stat was successfully destroyed"
  end
end
