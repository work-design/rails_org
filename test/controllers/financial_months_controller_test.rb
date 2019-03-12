require 'test_helper'

class FinancialMonthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @financial_month = financial_months(:one)
  end

  test "should get index" do
    get financial_months_url
    assert_response :success
  end

  test "should get new" do
    get new_financial_month_url
    assert_response :success
  end

  test "should create financial_month" do
    assert_difference('FinancialMonth.count') do
      post financial_months_url, params: { financial_month: {  } }
    end

    assert_redirected_to financial_month_url(FinancialMonth.last)
  end

  test "should show financial_month" do
    get financial_month_url(@financial_month)
    assert_response :success
  end

  test "should get edit" do
    get edit_financial_month_url(@financial_month)
    assert_response :success
  end

  test "should update financial_month" do
    patch financial_month_url(@financial_month), params: { financial_month: {  } }
    assert_redirected_to financial_month_url(@financial_month)
  end

  test "should destroy financial_month" do
    assert_difference('FinancialMonth.count', -1) do
      delete financial_month_url(@financial_month)
    end

    assert_redirected_to financial_months_url
  end
end
