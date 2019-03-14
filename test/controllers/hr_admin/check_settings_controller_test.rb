require 'test_helper'

class Org::CheckSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hr_check_setting = panel_check_settings(:one)
  end

  test "should get index" do
    get panel_check_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_panel_check_setting_url
    assert_response :success
  end

  test "should create panel_check_setting" do
    assert_difference('CheckSetting.count') do
      post panel_check_settings_url, params: { panel_check_setting: {  } }
    end

    assert_redirected_to panel_check_setting_url(CheckSetting.last)
  end

  test "should show panel_check_setting" do
    get panel_check_setting_url(@hr_check_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_panel_check_setting_url(@hr_check_setting)
    assert_response :success
  end

  test "should update panel_check_setting" do
    patch panel_check_setting_url(@hr_check_setting), params: { panel_check_setting: {  } }
    assert_redirected_to panel_check_setting_url(@hr_check_setting)
  end

  test "should destroy panel_check_setting" do
    assert_difference('CheckSetting.count', -1) do
      delete panel_check_setting_url(@hr_check_setting)
    end

    assert_redirected_to panel_check_settings_url
  end
end
