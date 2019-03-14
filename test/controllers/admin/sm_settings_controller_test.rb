require 'test_helper'

class Admin::SmSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @panel_sm_setting = panel_sm_settings(:one)
  end

  test "should get index" do
    get panel_sm_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_panel_sm_setting_url
    assert_response :success
  end

  test "should create panel_sm_setting" do
    assert_difference('SmSetting.count') do
      post panel_sm_settings_url, params: { panel_sm_setting: {  } }
    end

    assert_redirected_to panel_sm_setting_url(SmSetting.last)
  end

  test "should show panel_sm_setting" do
    get panel_sm_setting_url(@panel_sm_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_panel_sm_setting_url(@panel_sm_setting)
    assert_response :success
  end

  test "should update panel_sm_setting" do
    patch panel_sm_setting_url(@panel_sm_setting), params: { panel_sm_setting: {  } }
    assert_redirected_to panel_sm_setting_url(@panel_sm_setting)
  end

  test "should destroy panel_sm_setting" do
    assert_difference('SmSetting.count', -1) do
      delete panel_sm_setting_url(@panel_sm_setting)
    end

    assert_redirected_to panel_sm_settings_url
  end
end
