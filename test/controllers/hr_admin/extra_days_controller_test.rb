require 'test_helper'

class Org::ExtraDaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @extra_day = extra_days(:one)
  end

  test "should get index" do
    get extra_days_url
    assert_response :success
  end

  test "should get new" do
    get new_extra_day_url
    assert_response :success
  end

  test "should create extra_day" do
    assert_difference('ExtraDay.count') do
      post extra_days_url, params: { extra_day: {  } }
    end

    assert_redirected_to extra_day_url(ExtraDay.last)
  end

  test "should show extra_day" do
    get extra_day_url(@extra_day)
    assert_response :success
  end

  test "should get edit" do
    get edit_extra_day_url(@extra_day)
    assert_response :success
  end

  test "should update extra_day" do
    patch extra_day_url(@extra_day), params: { extra_day: {  } }
    assert_redirected_to extra_day_url(@extra_day)
  end

  test "should destroy extra_day" do
    assert_difference('ExtraDay.count', -1) do
      delete extra_day_url(@extra_day)
    end

    assert_redirected_to extra_days_url
  end
end
