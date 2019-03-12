require 'test_helper'

class OvertimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @overtime = overtimes(:one)
  end

  test "should get index" do
    get overtimes_url
    assert_response :success
  end

  test "should get new" do
    get new_overtime_url
    assert_response :success
  end

  test "should create overtime" do
    assert_difference('Overtime.count') do
      post overtimes_url, params: { overtime: {  } }
    end

    assert_redirected_to overtime_url(Overtime.last)
  end

  test "should show overtime" do
    get overtime_url(@overtime)
    assert_response :success
  end

  test "should get edit" do
    get edit_overtime_url(@overtime)
    assert_response :success
  end

  test "should update overtime" do
    patch overtime_url(@overtime), params: { overtime: {  } }
    assert_redirected_to overtime_url(@overtime)
  end

  test "should destroy overtime" do
    assert_difference('Overtime.count', -1) do
      delete overtime_url(@overtime)
    end

    assert_redirected_to overtimes_url
  end
end
