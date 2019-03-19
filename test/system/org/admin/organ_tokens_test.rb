require "application_system_test_case"

class OrganGrantsTest < ApplicationSystemTestCase
  setup do
    @org_panel_organ_grant = org_panel_organ_grants(:one)
  end

  test "visiting the index" do
    visit org_panel_organ_grants_url
    assert_selector "h1", text: "Organ Tokens"
  end

  test "creating a Organ token" do
    visit org_panel_organ_grants_url
    click_on "New Organ Token"

    fill_in "Expired at", with: @org_panel_organ_grant.expired_at
    fill_in "Member", with: @org_panel_organ_grant.member
    fill_in "Token", with: @org_panel_organ_grant.token
    fill_in "User", with: @org_panel_organ_grant.user
    click_on "Create Organ token"

    assert_text "Organ token was successfully created"
    click_on "Back"
  end

  test "updating a Organ token" do
    visit org_panel_organ_grants_url
    click_on "Edit", match: :first

    fill_in "Expired at", with: @org_panel_organ_grant.expired_at
    fill_in "Member", with: @org_panel_organ_grant.member
    fill_in "Token", with: @org_panel_organ_grant.token
    fill_in "User", with: @org_panel_organ_grant.user
    click_on "Update Organ token"

    assert_text "Organ token was successfully updated"
    click_on "Back"
  end

  test "destroying a Organ token" do
    visit org_panel_organ_grants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Organ token was successfully destroyed"
  end
end
