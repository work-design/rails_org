require 'test_helper'

class Org::Admin::OrganGrantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_panel_organ_grant = org_panel_organ_grants(:one)
  end

  test "should get index" do
    get panel_organ_grants_url
    assert_response :success
  end

  test "should get new" do
    get new_panel_organ_grant_url
    assert_response :success
  end

  test "should create org_panel_organ_grant" do
    assert_difference('OrganGrant.count') do
      post panel_organ_grants_url, params: { org_panel_organ_grant: { expire_at: @org_panel_organ_grant.expire_at, member: @org_panel_organ_grant.member, token: @org_panel_organ_grant.token, user: @org_panel_organ_grant.user } }
    end

    assert_redirected_to org_panel_organ_grant_url(OrganGrant.last)
  end

  test "should show org_panel_organ_grant" do
    get panel_organ_grant_url(@org_panel_organ_grant)
    assert_response :success
  end

  test "should get edit" do
    get edit_panel_organ_grant_url(@org_panel_organ_grant)
    assert_response :success
  end

  test "should update org_panel_organ_grant" do
    patch panel_organ_grant_url(@org_panel_organ_grant), params: { org_panel_organ_grant: { expire_at: @org_panel_organ_grant.expire_at, member: @org_panel_organ_grant.member, token: @org_panel_organ_grant.token, user: @org_panel_organ_grant.user } }
    assert_redirected_to org_panel_organ_grant_url(@org_panel_organ_grant)
  end

  test "should destroy org_panel_organ_grant" do
    assert_difference('OrganGrant.count', -1) do
      delete panel_organ_grant_url(@org_panel_organ_grant)
    end

    assert_redirected_to panel_organ_grants_url
  end
end
