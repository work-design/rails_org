require "application_system_test_case"

class SuperJobTitlesTest < ApplicationSystemTestCase
  setup do
    @org_admin_super_job_title = org_admin_super_job_titles(:one)
  end

  test "visiting the index" do
    visit org_admin_super_job_titles_url
    assert_selector "h1", text: "Super Job Titles"
  end

  test "creating a Super job title" do
    visit org_admin_super_job_titles_url
    click_on "New Super Job Title"

    fill_in "Description", with: @org_admin_super_job_title.description
    fill_in "Grade", with: @org_admin_super_job_title.grade
    fill_in "Name", with: @org_admin_super_job_title.name
    click_on "Create Super job title"

    assert_text "Super job title was successfully created"
    click_on "Back"
  end

  test "updating a Super job title" do
    visit org_admin_super_job_titles_url
    click_on "Edit", match: :first

    fill_in "Description", with: @org_admin_super_job_title.description
    fill_in "Grade", with: @org_admin_super_job_title.grade
    fill_in "Name", with: @org_admin_super_job_title.name
    click_on "Update Super job title"

    assert_text "Super job title was successfully updated"
    click_on "Back"
  end

  test "destroying a Super job title" do
    visit org_admin_super_job_titles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Super job title was successfully destroyed"
  end
end
