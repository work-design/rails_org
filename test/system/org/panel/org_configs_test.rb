require "application_system_test_case"

class OrgConfigsTest < ApplicationSystemTestCase
  setup do
    @org_panel_org_config = org_panel_org_configs(:one)
  end

  test "visiting the index" do
    visit org_panel_org_configs_url
    assert_selector "h1", text: "Org Configs"
  end

  test "creating a Org config" do
    visit org_panel_org_configs_url
    click_on "New Org Config"

    fill_in "Description", with: @org_panel_org_config.description
    fill_in "Job title", with: @org_panel_org_config.job_title_id
    fill_in "Name", with: @org_panel_org_config.name
    fill_in "Record class", with: @org_panel_org_config.record_class
    fill_in "Record column", with: @org_panel_org_config.record_column
    click_on "Create Org config"

    assert_text "Org config was successfully created"
    click_on "Back"
  end

  test "updating a Org config" do
    visit org_panel_org_configs_url
    click_on "Edit", match: :first

    fill_in "Description", with: @org_panel_org_config.description
    fill_in "Job title", with: @org_panel_org_config.job_title_id
    fill_in "Name", with: @org_panel_org_config.name
    fill_in "Record class", with: @org_panel_org_config.record_class
    fill_in "Record column", with: @org_panel_org_config.record_column
    click_on "Update Org config"

    assert_text "Org config was successfully updated"
    click_on "Back"
  end

  test "destroying a Org config" do
    visit org_panel_org_configs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Org config was successfully destroyed"
  end
end
