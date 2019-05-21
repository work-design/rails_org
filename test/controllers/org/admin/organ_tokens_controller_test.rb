require 'test_helper'

class Org::Admin::OrganGrantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_admin_organ_grant = org_admin_organ_grants(:one)
  end

  test "should get index" do
    get admin_organ_grants_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_organ_grant_url
    assert_response :success
  end

  test "should create org_admin_organ_grant" do
    assert_difference('OrganGrant.count') do
      post admin_organ_grants_url, params: { org_admin_organ_grant: { expire_at: @org_admin_organ_grant.expire_at, member: @org_admin_organ_grant.member, token: @org_admin_organ_grant.token, user: @org_admin_organ_grant.user } }
    end

    assert_redirected_to org_admin_organ_grant_url(OrganGrant.last)
  end

  test "should show org_admin_organ_grant" do
    get admin_organ_grant_url(@org_admin_organ_grant)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_organ_grant_url(@org_admin_organ_grant)
    assert_response :success
  end

  test "should update org_admin_organ_grant" do
    patch admin_organ_grant_url(@org_admin_organ_grant), params: { org_admin_organ_grant: { expire_at: @org_admin_organ_grant.expire_at, member: @org_admin_organ_grant.member, token: @org_admin_organ_grant.token, user: @org_admin_organ_grant.user } }
    assert_redirected_to org_admin_organ_grant_url(@org_admin_organ_grant)
  end

  test "should destroy org_admin_organ_grant" do
    assert_difference('OrganGrant.count', -1) do
      delete admin_organ_grant_url(@org_admin_organ_grant)
    end

    assert_redirected_to admin_organ_grants_url
  end
end
