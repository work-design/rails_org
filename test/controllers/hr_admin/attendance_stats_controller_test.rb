require 'test_helper'

class Org::AttendanceStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hr_attendance_stat = admin_attendance_stats(:one)
  end

  test "should get index" do
    get admin_attendance_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_attendance_stat_url
    assert_response :success
  end

  test "should create admin_attendance_stat" do
    assert_difference('AttendanceStat.count') do
      post admin_attendance_stats_url, params: { admin_attendance_stat: {  } }
    end

    assert_redirected_to admin_attendance_stat_url(AttendanceStat.last)
  end

  test "should show admin_attendance_stat" do
    get admin_attendance_stat_url(@hr_attendance_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_attendance_stat_url(@hr_attendance_stat)
    assert_response :success
  end

  test "should update admin_attendance_stat" do
    patch admin_attendance_stat_url(@hr_attendance_stat), params: { admin_attendance_stat: {  } }
    assert_redirected_to admin_attendance_stat_url(@hr_attendance_stat)
  end

  test "should destroy admin_attendance_stat" do
    assert_difference('AttendanceStat.count', -1) do
      delete admin_attendance_stat_url(@hr_attendance_stat)
    end

    assert_redirected_to admin_attendance_stats_url
  end
end
