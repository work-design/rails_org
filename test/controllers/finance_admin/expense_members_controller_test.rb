require 'test_helper'

class Finance::ExpenseMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @finance_expense_member = finance_expense_members(:one)
  end

  test "should get index" do
    get finance_expense_members_url
    assert_response :success
  end

  test "should get new" do
    get new_finance_expense_member_url
    assert_response :success
  end

  test "should create finance_expense_member" do
    assert_difference('ExpenseMember.count') do
      post finance_expense_members_url, params: { finance_expense_member: {  } }
    end

    assert_redirected_to finance_expense_member_url(ExpenseMember.last)
  end

  test "should show finance_expense_member" do
    get finance_expense_member_url(@finance_expense_member)
    assert_response :success
  end

  test "should get edit" do
    get edit_finance_expense_member_url(@finance_expense_member)
    assert_response :success
  end

  test "should update finance_expense_member" do
    patch finance_expense_member_url(@finance_expense_member), params: { finance_expense_member: {  } }
    assert_redirected_to finance_expense_member_url(@finance_expense_member)
  end

  test "should destroy finance_expense_member" do
    assert_difference('ExpenseMember.count', -1) do
      delete finance_expense_member_url(@finance_expense_member)
    end

    assert_redirected_to finance_expense_members_url
  end
end
