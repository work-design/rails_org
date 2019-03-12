require 'test_helper'

class PayoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payout = payouts(:one)
  end

  test "should get index" do
    get payouts_url
    assert_response :success
  end

  test "should get new" do
    get new_payout_url
    assert_response :success
  end

  test "should create payout" do
    assert_difference('Payout.count') do
      post payouts_url, params: { payout: {  } }
    end

    assert_redirected_to payout_url(Payout.last)
  end

  test "should show payout" do
    get payout_url(@payout)
    assert_response :success
  end

  test "should get edit" do
    get edit_payout_url(@payout)
    assert_response :success
  end

  test "should update payout" do
    patch payout_url(@payout), params: { payout: {  } }
    assert_redirected_to payout_url(@payout)
  end

  test "should destroy payout" do
    assert_difference('Payout.count', -1) do
      delete payout_url(@payout)
    end

    assert_redirected_to payouts_url
  end
end
