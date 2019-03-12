require 'test_helper'

class ResignReasonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resign_reason = resign_reasons(:one)
  end

  test "should get index" do
    get resign_reasons_url
    assert_response :success
  end

  test "should get new" do
    get new_resign_reason_url
    assert_response :success
  end

  test "should create resign_reason" do
    assert_difference('ResignReason.count') do
      post resign_reasons_url, params: { resign_reason: {  } }
    end

    assert_redirected_to resign_reason_url(ResignReason.last)
  end

  test "should show resign_reason" do
    get resign_reason_url(@resign_reason)
    assert_response :success
  end

  test "should get edit" do
    get edit_resign_reason_url(@resign_reason)
    assert_response :success
  end

  test "should update resign_reason" do
    patch resign_reason_url(@resign_reason), params: { resign_reason: {  } }
    assert_redirected_to resign_reason_url(@resign_reason)
  end

  test "should destroy resign_reason" do
    assert_difference('ResignReason.count', -1) do
      delete resign_reason_url(@resign_reason)
    end

    assert_redirected_to resign_reasons_url
  end
end
