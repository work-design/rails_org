require 'test_helper'

class ResignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resign = resigns(:one)
  end

  test "should get index" do
    get resigns_url
    assert_response :success
  end

  test "should get new" do
    get new_resign_url
    assert_response :success
  end

  test "should create resign" do
    assert_difference('Resign.count') do
      post resigns_url, params: { resign: {  } }
    end

    assert_redirected_to resign_url(Resign.last)
  end

  test "should show resign" do
    get resign_url(@resign)
    assert_response :success
  end

  test "should get edit" do
    get edit_resign_url(@resign)
    assert_response :success
  end

  test "should update resign" do
    patch resign_url(@resign), params: { resign: {  } }
    assert_redirected_to resign_url(@resign)
  end

  test "should destroy resign" do
    assert_difference('Resign.count', -1) do
      delete resign_url(@resign)
    end

    assert_redirected_to resigns_url
  end
end
