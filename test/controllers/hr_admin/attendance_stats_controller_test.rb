require 'test_helper'

class Org::AttendanceStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hr_attendance_stat = panel_attendance_stats(:one)
  end

  test "should get index" do
    get panel_attendance_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_panel_attendance_stat_url
    assert_response :success
  end

  test "should create panel_attendance_stat" do
    assert_difference('AttendanceStat.count') do
      post panel_attendance_stats_url, params: { panel_attendance_stat: {  } }
    end

    assert_redirected_to panel_attendance_stat_url(AttendanceStat.last)
  end

  test "should show panel_attendance_stat" do
    get panel_attendance_stat_url(@hr_attendance_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_panel_attendance_stat_url(@hr_attendance_stat)
    assert_response :success
  end

  test "should update panel_attendance_stat" do
    patch panel_attendance_stat_url(@hr_attendance_stat), params: { panel_attendance_stat: {  } }
    assert_redirected_to panel_attendance_stat_url(@hr_attendance_stat)
  end

  test "should destroy panel_attendance_stat" do
    assert_difference('AttendanceStat.count', -1) do
      delete panel_attendance_stat_url(@hr_attendance_stat)
    end

    assert_redirected_to panel_attendance_stats_url
  end
end
