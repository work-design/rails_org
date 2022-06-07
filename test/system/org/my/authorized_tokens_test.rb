require "application_system_test_case"

class AuthorizedTokensTest < ApplicationSystemTestCase
  setup do
    @org_my_authorized_token = org_my_authorized_tokens(:one)
  end

  test "visiting the index" do
    visit org_my_authorized_tokens_url
    assert_selector "h1", text: "Authorized tokens"
  end

  test "should create authorized token" do
    visit org_my_authorized_tokens_url
    click_on "New authorized token"

    fill_in "Member", with: @org_my_authorized_token.member_id
    fill_in "User", with: @org_my_authorized_token.user_id
    click_on "Create Authorized token"

    assert_text "Authorized token was successfully created"
    click_on "Back"
  end

  test "should update Authorized token" do
    visit org_my_authorized_token_url(@org_my_authorized_token)
    click_on "Edit this authorized token", match: :first

    fill_in "Member", with: @org_my_authorized_token.member_id
    fill_in "User", with: @org_my_authorized_token.user_id
    click_on "Update Authorized token"

    assert_text "Authorized token was successfully updated"
    click_on "Back"
  end

  test "should destroy Authorized token" do
    visit org_my_authorized_token_url(@org_my_authorized_token)
    click_on "Destroy this authorized token", match: :first

    assert_text "Authorized token was successfully destroyed"
  end
end
