require "application_system_test_case"

class DepartmentJournalsTest < ApplicationSystemTestCase
  setup do
    @department_journal = department_journals(:one)
  end

  test "visiting the index" do
    visit department_journals_url
    assert_selector "h1", text: "Department Journals"
  end

  test "creating a Department journal" do
    visit department_journals_url
    click_on "New Department Journal"

    click_on "Create Department journal"

    assert_text "Department journal was successfully created"
    click_on "Back"
  end

  test "updating a Department journal" do
    visit department_journals_url
    click_on "Edit", match: :first

    click_on "Update Department journal"

    assert_text "Department journal was successfully updated"
    click_on "Back"
  end

  test "destroying a Department journal" do
    visit department_journals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Department journal was successfully destroyed"
  end
end
