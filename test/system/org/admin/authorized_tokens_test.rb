require "application_system_test_case"

class AuthorizedTokensTest < ApplicationSystemTestCase
  setup do
    @org_admin_authorized_token = org_admin_authorized_tokens(:one)
  end

  test "visiting the index" do
    visit org_admin_authorized_tokens_url
    assert_selector "h1", text: "Authorized Tokens"
  end

  test "creating a Authorized token" do
    visit org_admin_authorized_tokens_url
    click_on "New Authorized Token"

    fill_in "Expire at", with: @org_admin_authorized_token.expire_at
    fill_in "Mock member", with: @org_admin_authorized_token.mock_member
    fill_in "Oauth user", with: @org_admin_authorized_token.oauth_user_id
    fill_in "Token", with: @org_admin_authorized_token.token
    fill_in "User", with: @org_admin_authorized_token.user_id
    click_on "Create Authorized token"

    assert_text "Authorized token was successfully created"
    click_on "Back"
  end

  test "updating a Authorized token" do
    visit org_admin_authorized_tokens_url
    click_on "Edit", match: :first

    fill_in "Expire at", with: @org_admin_authorized_token.expire_at
    fill_in "Mock member", with: @org_admin_authorized_token.mock_member
    fill_in "Oauth user", with: @org_admin_authorized_token.oauth_user_id
    fill_in "Token", with: @org_admin_authorized_token.token
    fill_in "User", with: @org_admin_authorized_token.user_id
    click_on "Update Authorized token"

    assert_text "Authorized token was successfully updated"
    click_on "Back"
  end

  test "destroying a Authorized token" do
    visit org_admin_authorized_tokens_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Authorized token was successfully destroyed"
  end
end
