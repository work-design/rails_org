require 'test_helper'

class Hr::My::ExpenseMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_expense_member = my_expense_members(:one)
  end

  test "should get index" do
    get my_expense_members_url
    assert_response :success
  end

  test "should get new" do
    get new_my_expense_member_url
    assert_response :success
  end

  test "should create my_expense_member" do
    assert_difference('ExpenseMember.count') do
      post my_expense_members_url, params: { my_expense_member: {  } }
    end

    assert_redirected_to my_expense_member_url(ExpenseMember.last)
  end

  test "should show my_expense_member" do
    get my_expense_member_url(@my_expense_member)
    assert_response :success
  end

  test "should get edit" do
    get edit_my_expense_member_url(@my_expense_member)
    assert_response :success
  end

  test "should update my_expense_member" do
    patch my_expense_member_url(@my_expense_member), params: { my_expense_member: {  } }
    assert_redirected_to my_expense_member_url(@my_expense_member)
  end

  test "should destroy my_expense_member" do
    assert_difference('ExpenseMember.count', -1) do
      delete my_expense_member_url(@my_expense_member)
    end

    assert_redirected_to my_expense_members_url
  end
end
