require 'test_helper'

class Org::Admin::OrganTokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_admin_organ_token = org_admin_organ_tokens(:one)
  end

  test "should get index" do
    get admin_organ_tokens_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_organ_token_url
    assert_response :success
  end

  test "should create org_admin_organ_token" do
    assert_difference('OrganToken.count') do
      post admin_organ_tokens_url, params: { org_admin_organ_token: { expired_at: @org_admin_organ_token.expired_at, member: @org_admin_organ_token.member, token: @org_admin_organ_token.token, user: @org_admin_organ_token.user } }
    end

    assert_redirected_to org_admin_organ_token_url(OrganToken.last)
  end

  test "should show org_admin_organ_token" do
    get admin_organ_token_url(@org_admin_organ_token)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_organ_token_url(@org_admin_organ_token)
    assert_response :success
  end

  test "should update org_admin_organ_token" do
    patch admin_organ_token_url(@org_admin_organ_token), params: { org_admin_organ_token: { expired_at: @org_admin_organ_token.expired_at, member: @org_admin_organ_token.member, token: @org_admin_organ_token.token, user: @org_admin_organ_token.user } }
    assert_redirected_to org_admin_organ_token_url(@org_admin_organ_token)
  end

  test "should destroy org_admin_organ_token" do
    assert_difference('OrganToken.count', -1) do
      delete admin_organ_token_url(@org_admin_organ_token)
    end

    assert_redirected_to admin_organ_tokens_url
  end
end
