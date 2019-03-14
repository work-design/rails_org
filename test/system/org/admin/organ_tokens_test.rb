require "application_system_test_case"

class OrganTokensTest < ApplicationSystemTestCase
  setup do
    @org_panel_organ_token = org_panel_organ_tokens(:one)
  end

  test "visiting the index" do
    visit org_panel_organ_tokens_url
    assert_selector "h1", text: "Organ Tokens"
  end

  test "creating a Organ token" do
    visit org_panel_organ_tokens_url
    click_on "New Organ Token"

    fill_in "Expired at", with: @org_panel_organ_token.expired_at
    fill_in "Member", with: @org_panel_organ_token.member
    fill_in "Token", with: @org_panel_organ_token.token
    fill_in "User", with: @org_panel_organ_token.user
    click_on "Create Organ token"

    assert_text "Organ token was successfully created"
    click_on "Back"
  end

  test "updating a Organ token" do
    visit org_panel_organ_tokens_url
    click_on "Edit", match: :first

    fill_in "Expired at", with: @org_panel_organ_token.expired_at
    fill_in "Member", with: @org_panel_organ_token.member
    fill_in "Token", with: @org_panel_organ_token.token
    fill_in "User", with: @org_panel_organ_token.user
    click_on "Update Organ token"

    assert_text "Organ token was successfully updated"
    click_on "Back"
  end

  test "destroying a Organ token" do
    visit org_panel_organ_tokens_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Organ token was successfully destroyed"
  end
end
