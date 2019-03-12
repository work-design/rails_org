require "application_system_test_case"

class AttendanceSettingsTest < ApplicationSystemTestCase
  setup do
    @oa_attendance_setting = oa_attendance_settings(:one)
  end

  test "visiting the index" do
    visit oa_attendance_settings_url
    assert_selector "h1", text: "Attendance Settings"
  end

  test "creating a Attendance setting" do
    visit oa_attendance_settings_url
    click_on "New Attendance Setting"

    fill_in "Note", with: @oa_attendance_setting.note
    fill_in "On Time", with: @oa_attendance_setting.on_time
    fill_in "State", with: @oa_attendance_setting.state
    click_on "Create Attendance setting"

    assert_text "Attendance setting was successfully created"
    click_on "Back"
  end

  test "updating a Attendance setting" do
    visit oa_attendance_settings_url
    click_on "Edit", match: :first

    fill_in "Note", with: @oa_attendance_setting.note
    fill_in "On Time", with: @oa_attendance_setting.on_time
    fill_in "State", with: @oa_attendance_setting.state
    click_on "Update Attendance setting"

    assert_text "Attendance setting was successfully updated"
    click_on "Back"
  end

  test "destroying a Attendance setting" do
    visit oa_attendance_settings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Attendance setting was successfully destroyed"
  end
end
