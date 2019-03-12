require 'test_helper'

class Admin::SmSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_sm_setting = admin_sm_settings(:one)
  end

  test "should get index" do
    get admin_sm_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_sm_setting_url
    assert_response :success
  end

  test "should create admin_sm_setting" do
    assert_difference('SmSetting.count') do
      post admin_sm_settings_url, params: { admin_sm_setting: {  } }
    end

    assert_redirected_to admin_sm_setting_url(SmSetting.last)
  end

  test "should show admin_sm_setting" do
    get admin_sm_setting_url(@admin_sm_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_sm_setting_url(@admin_sm_setting)
    assert_response :success
  end

  test "should update admin_sm_setting" do
    patch admin_sm_setting_url(@admin_sm_setting), params: { admin_sm_setting: {  } }
    assert_redirected_to admin_sm_setting_url(@admin_sm_setting)
  end

  test "should destroy admin_sm_setting" do
    assert_difference('SmSetting.count', -1) do
      delete admin_sm_setting_url(@admin_sm_setting)
    end

    assert_redirected_to admin_sm_settings_url
  end
end
