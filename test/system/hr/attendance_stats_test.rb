require "application_system_test_case"

class AttendanceStatsTest < ApplicationSystemTestCase
  setup do
    @hr_attendance_stat = admin_attendance_stats(:one)
  end

  test "visiting the index" do
    visit admin_attendance_stats_url
    assert_selector "h1", text: "Attendance Stats"
  end

  test "creating a Attendance stat" do
    visit admin_attendance_stats_url
    click_on "New Attendance Stat"

    click_on "Create Attendance stat"

    assert_text "Attendance stat was successfully created"
    click_on "Back"
  end

  test "updating a Attendance stat" do
    visit admin_attendance_stats_url
    click_on "Edit", match: :first

    click_on "Update Attendance stat"

    assert_text "Attendance stat was successfully updated"
    click_on "Back"
  end

  test "destroying a Attendance stat" do
    visit admin_attendance_stats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Attendance stat was successfully destroyed"
  end
end
