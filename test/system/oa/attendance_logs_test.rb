require "application_system_test_case"

class AttendanceLogsTest < ApplicationSystemTestCase
  setup do
    @oa_attendance_log = oa_attendance_logs(:one)
  end

  test "visiting the index" do
    visit oa_attendance_logs_url
    assert_selector "h1", text: "Attendance Logs"
  end

  test "creating a Attendance log" do
    visit oa_attendance_logs_url
    click_on "New Attendance Log"

    click_on "Create Attendance log"

    assert_text "Attendance log was successfully created"
    click_on "Back"
  end

  test "updating a Attendance log" do
    visit oa_attendance_logs_url
    click_on "Edit", match: :first

    click_on "Update Attendance log"

    assert_text "Attendance log was successfully updated"
    click_on "Back"
  end

  test "destroying a Attendance log" do
    visit oa_attendance_logs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Attendance log was successfully destroyed"
  end
end
