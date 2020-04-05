require 'test_helper'
class Org::Mine::MembersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @org_mine_member = create org_mine_members
  end

  test 'index ok' do
    get mine_members_url
    assert_response :success
  end

  test 'new ok' do
    get new_mine_member_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Member.count') do
      post mine_members_url, params: {  }
    end

    assert_response :success
  end

  test 'show ok' do
    get mine_member_url(@org_mine_member)
    assert_response :success
  end

  test 'edit ok' do
    get edit_mine_member_url(@org_mine_member)
    assert_response :success
  end

  test 'update ok' do
    patch mine_member_url(@org_mine_member), params: {  }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Member.count', -1) do
      delete mine_member_url(@org_mine_member)
    end

    assert_response :success
  end

end
