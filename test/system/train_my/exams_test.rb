require "application_system_test_case"

class ExamsTest < ApplicationSystemTestCase
  setup do
    @train_my_exam = train_my_exams(:one)
  end

  test "visiting the index" do
    visit train_my_exams_url
    assert_selector "h1", text: "Exams"
  end

  test "creating a Exam" do
    visit train_my_exams_url
    click_on "New Exam"

    click_on "Create Exam"

    assert_text "Exam was successfully created"
    click_on "Back"
  end

  test "updating a Exam" do
    visit train_my_exams_url
    click_on "Edit", match: :first

    click_on "Update Exam"

    assert_text "Exam was successfully updated"
    click_on "Back"
  end

  test "destroying a Exam" do
    visit train_my_exams_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Exam was successfully destroyed"
  end
end
