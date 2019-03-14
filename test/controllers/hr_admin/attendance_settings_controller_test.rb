require 'test_helper'

class Org::AttendanceSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hr_attendance_setting = panel_attendance_settings(:one)
  end

  test "should get index" do
    get panel_attendance_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_panel_attendance_setting_url
    assert_response :success
  end

  test "should create panel_attendance_setting" do
    assert_difference('AttendanceSetting.count') do
      post panel_attendance_settings_url, params: { panel_attendance_setting: { note: @hr_attendance_setting.note, on_time: @hr_attendance_setting.on_time, state: @hr_attendance_setting.state } }
    end

    assert_redirected_to panel_attendance_setting_url(AttendanceSetting.last)
  end

  test "should show panel_attendance_setting" do
    get panel_attendance_setting_url(@hr_attendance_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_panel_attendance_setting_url(@hr_attendance_setting)
    assert_response :success
  end

  test "should update panel_attendance_setting" do
    patch panel_attendance_setting_url(@hr_attendance_setting), params: { panel_attendance_setting: { note: @hr_attendance_setting.note, on_time: @hr_attendance_setting.on_time, state: @hr_attendance_setting.state } }
    assert_redirected_to panel_attendance_setting_url(@hr_attendance_setting)
  end

  test "should destroy panel_attendance_setting" do
    assert_difference('AttendanceSetting.count', -1) do
      delete panel_attendance_setting_url(@hr_attendance_setting)
    end

    assert_redirected_to panel_attendance_settings_url
  end
end
