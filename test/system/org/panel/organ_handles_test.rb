require "application_system_test_case"

class OrganHandlesTest < ApplicationSystemTestCase
  setup do
    @org_admin_organ_handle = org_admin_organ_handles(:one)
  end

  test "visiting the index" do
    visit org_admin_organ_handles_url
    assert_selector "h1", text: "Organ Handles"
  end

  test "creating a Organ handle" do
    visit org_admin_organ_handles_url
    click_on "New Organ Handle"

    fill_in "Description", with: @org_admin_organ_handle.description
    fill_in "Job title", with: @org_admin_organ_handle.job_title_id
    fill_in "Name", with: @org_admin_organ_handle.name
    click_on "Create Organ handle"

    assert_text "Organ handle was successfully created"
    click_on "Back"
  end

  test "updating a Organ handle" do
    visit org_admin_organ_handles_url
    click_on "Edit", match: :first

    fill_in "Description", with: @org_admin_organ_handle.description
    fill_in "Job title", with: @org_admin_organ_handle.job_title_id
    fill_in "Name", with: @org_admin_organ_handle.name
    click_on "Update Organ handle"

    assert_text "Organ handle was successfully updated"
    click_on "Back"
  end

  test "destroying a Organ handle" do
    visit org_admin_organ_handles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Organ handle was successfully destroyed"
  end
end
