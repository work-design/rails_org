require "application_system_test_case"

class DepartmentGrantsTest < ApplicationSystemTestCase
  setup do
    @org_panel_department_grant = org_panel_department_grants(:one)
  end

  test "visiting the index" do
    visit org_panel_department_grants_url
    assert_selector "h1", text: "Department Grants"
  end

  test "creating a Department grant" do
    visit org_panel_department_grants_url
    click_on "New Department Grant"

    fill_in "Department", with: @org_panel_department_grant.department_id
    fill_in "Job title", with: @org_panel_department_grant.job_title_id
    fill_in "Organ handle", with: @org_panel_department_grant.organ_handle_id
    click_on "Create Department grant"

    assert_text "Department grant was successfully created"
    click_on "Back"
  end

  test "updating a Department grant" do
    visit org_panel_department_grants_url
    click_on "Edit", match: :first

    fill_in "Department", with: @org_panel_department_grant.department_id
    fill_in "Job title", with: @org_panel_department_grant.job_title_id
    fill_in "Organ handle", with: @org_panel_department_grant.organ_handle_id
    click_on "Update Department grant"

    assert_text "Department grant was successfully updated"
    click_on "Back"
  end

  test "destroying a Department grant" do
    visit org_panel_department_grants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Department grant was successfully destroyed"
  end
end
