require 'test_helper'

class Org::Admin::OrganTokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_panel_organ_token = org_panel_organ_tokens(:one)
  end

  test "should get index" do
    get panel_organ_tokens_url
    assert_response :success
  end

  test "should get new" do
    get new_panel_organ_token_url
    assert_response :success
  end

  test "should create org_panel_organ_token" do
    assert_difference('OrganToken.count') do
      post panel_organ_tokens_url, params: { org_panel_organ_token: { expired_at: @org_panel_organ_token.expired_at, member: @org_panel_organ_token.member, token: @org_panel_organ_token.token, user: @org_panel_organ_token.user } }
    end

    assert_redirected_to org_panel_organ_token_url(OrganToken.last)
  end

  test "should show org_panel_organ_token" do
    get panel_organ_token_url(@org_panel_organ_token)
    assert_response :success
  end

  test "should get edit" do
    get edit_panel_organ_token_url(@org_panel_organ_token)
    assert_response :success
  end

  test "should update org_panel_organ_token" do
    patch panel_organ_token_url(@org_panel_organ_token), params: { org_panel_organ_token: { expired_at: @org_panel_organ_token.expired_at, member: @org_panel_organ_token.member, token: @org_panel_organ_token.token, user: @org_panel_organ_token.user } }
    assert_redirected_to org_panel_organ_token_url(@org_panel_organ_token)
  end

  test "should destroy org_panel_organ_token" do
    assert_difference('OrganToken.count', -1) do
      delete panel_organ_token_url(@org_panel_organ_token)
    end

    assert_redirected_to panel_organ_tokens_url
  end
end
