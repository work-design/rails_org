require "application_system_test_case"

class MemberDepartmentsTest < ApplicationSystemTestCase
  setup do
    @org_panel_member_department = org_panel_member_departments(:one)
  end

  test "visiting the index" do
    visit org_panel_member_departments_url
    assert_selector "h1", text: "Member Departments"
  end

  test "creating a Member department" do
    visit org_panel_member_departments_url
    click_on "New Member Department"

    fill_in "Job title", with: @org_panel_member_department.job_title_id
    fill_in "Office", with: @org_panel_member_department.office_id
    click_on "Create Member department"

    assert_text "Member department was successfully created"
    click_on "Back"
  end

  test "updating a Member department" do
    visit org_panel_member_departments_url
    click_on "Edit", match: :first

    fill_in "Job title", with: @org_panel_member_department.job_title_id
    fill_in "Office", with: @org_panel_member_department.office_id
    click_on "Update Member department"

    assert_text "Member department was successfully updated"
    click_on "Back"
  end

  test "destroying a Member department" do
    visit org_panel_member_departments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Member department was successfully destroyed"
  end
end
