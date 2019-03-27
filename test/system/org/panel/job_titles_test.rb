require "application_system_test_case"

class JobTitlesTest < ApplicationSystemTestCase
  setup do
    @org_panel_job_title = org_panel_job_titles(:one)
  end

  test "visiting the index" do
    visit org_panel_job_titles_url
    assert_selector "h1", text: "Job Titles"
  end

  test "creating a Job title" do
    visit org_panel_job_titles_url
    click_on "New Job Title"

    fill_in "Department", with: @org_panel_job_title.department
    fill_in "Grade", with: @org_panel_job_title.grade
    fill_in "Name", with: @org_panel_job_title.name
    click_on "Create Job title"

    assert_text "Job title was successfully created"
    click_on "Back"
  end

  test "updating a Job title" do
    visit org_panel_job_titles_url
    click_on "Edit", match: :first

    fill_in "Department", with: @org_panel_job_title.department
    fill_in "Grade", with: @org_panel_job_title.grade
    fill_in "Name", with: @org_panel_job_title.name
    click_on "Update Job title"

    assert_text "Job title was successfully updated"
    click_on "Back"
  end

  test "destroying a Job title" do
    visit org_panel_job_titles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Job title was successfully destroyed"
  end
end
