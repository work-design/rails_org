require "application_system_test_case"

class JobDescriptionsTest < ApplicationSystemTestCase
  setup do
    @job_description = job_descriptions(:one)
  end

  test "visiting the index" do
    visit job_descriptions_url
    assert_selector "h1", text: "Job Descriptions"
  end

  test "creating a Job description" do
    visit job_descriptions_url
    click_on "New Job Description"

    click_on "Create Job description"

    assert_text "Job description was successfully created"
    click_on "Back"
  end

  test "updating a Job description" do
    visit job_descriptions_url
    click_on "Edit", match: :first

    click_on "Update Job description"

    assert_text "Job description was successfully updated"
    click_on "Back"
  end

  test "destroying a Job description" do
    visit job_descriptions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Job description was successfully destroyed"
  end
end
