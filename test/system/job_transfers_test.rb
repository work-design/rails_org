require "application_system_test_case"

class JobTransfersTest < ApplicationSystemTestCase
  setup do
    @job_transfer = job_transfers(:one)
  end

  test "visiting the index" do
    visit job_transfers_url
    assert_selector "h1", text: "Job Transfers"
  end

  test "creating a Job transfer" do
    visit job_transfers_url
    click_on "New Job Transfer"

    click_on "Create Job transfer"

    assert_text "Job transfer was successfully created"
    click_on "Back"
  end

  test "updating a Job transfer" do
    visit job_transfers_url
    click_on "Edit", match: :first

    click_on "Update Job transfer"

    assert_text "Job transfer was successfully updated"
    click_on "Back"
  end

  test "destroying a Job transfer" do
    visit job_transfers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Job transfer was successfully destroyed"
  end
end
