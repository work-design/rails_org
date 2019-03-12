require 'test_helper'

class Hr::CheckSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hr_check_setting = admin_check_settings(:one)
  end

  test "should get index" do
    get admin_check_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_check_setting_url
    assert_response :success
  end

  test "should create admin_check_setting" do
    assert_difference('CheckSetting.count') do
      post admin_check_settings_url, params: { admin_check_setting: {  } }
    end

    assert_redirected_to admin_check_setting_url(CheckSetting.last)
  end

  test "should show admin_check_setting" do
    get admin_check_setting_url(@hr_check_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_check_setting_url(@hr_check_setting)
    assert_response :success
  end

  test "should update admin_check_setting" do
    patch admin_check_setting_url(@hr_check_setting), params: { admin_check_setting: {  } }
    assert_redirected_to admin_check_setting_url(@hr_check_setting)
  end

  test "should destroy admin_check_setting" do
    assert_difference('CheckSetting.count', -1) do
      delete admin_check_setting_url(@hr_check_setting)
    end

    assert_redirected_to admin_check_settings_url
  end
end
