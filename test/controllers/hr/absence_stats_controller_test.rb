require 'test_helper'

class Org::AbsenceStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hr_absence_stat = panel_absence_stats(:one)
  end

  test "should get index" do
    get panel_absence_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_panel_absence_stat_url
    assert_response :success
  end

  test "should create panel_absence_stat" do
    assert_difference('AbsenceStat.count') do
      post panel_absence_stats_url, params: { panel_absence_stat: {  } }
    end

    assert_redirected_to panel_absence_stat_url(AbsenceStat.last)
  end

  test "should show panel_absence_stat" do
    get panel_absence_stat_url(@hr_absence_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_panel_absence_stat_url(@hr_absence_stat)
    assert_response :success
  end

  test "should update panel_absence_stat" do
    patch panel_absence_stat_url(@hr_absence_stat), params: { panel_absence_stat: {  } }
    assert_redirected_to panel_absence_stat_url(@hr_absence_stat)
  end

  test "should destroy panel_absence_stat" do
    assert_difference('AbsenceStat.count', -1) do
      delete panel_absence_stat_url(@hr_absence_stat)
    end

    assert_redirected_to panel_absence_stats_url
  end
end
