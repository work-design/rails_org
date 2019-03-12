require "application_system_test_case"

class ExamPapersTest < ApplicationSystemTestCase
  setup do
    @train_exam_paper = train_exam_papers(:one)
  end

  test "visiting the index" do
    visit train_exam_papers_url
    assert_selector "h1", text: "Exam Papers"
  end

  test "creating a Exam paper" do
    visit train_exam_papers_url
    click_on "New Exam Paper"

    click_on "Create Exam paper"

    assert_text "Exam paper was successfully created"
    click_on "Back"
  end

  test "updating a Exam paper" do
    visit train_exam_papers_url
    click_on "Edit", match: :first

    click_on "Update Exam paper"

    assert_text "Exam paper was successfully updated"
    click_on "Back"
  end

  test "destroying a Exam paper" do
    visit train_exam_papers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Exam paper was successfully destroyed"
  end
end
