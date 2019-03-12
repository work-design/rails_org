require "application_system_test_case"

class ExamPagersTest < ApplicationSystemTestCase
  setup do
    @train_exam_pager = train_exam_pagers(:one)
  end

  test "visiting the index" do
    visit train_exam_pagers_url
    assert_selector "h1", text: "Exam Pagers"
  end

  test "creating a Exam pager" do
    visit train_exam_pagers_url
    click_on "New Exam Pager"

    fill_in "Description", with: @train_exam_pager.description
    fill_in "Title", with: @train_exam_pager.title
    click_on "Create Exam pager"

    assert_text "Exam pager was successfully created"
    click_on "Back"
  end

  test "updating a Exam pager" do
    visit train_exam_pagers_url
    click_on "Edit", match: :first

    fill_in "Description", with: @train_exam_pager.description
    fill_in "Title", with: @train_exam_pager.title
    click_on "Update Exam pager"

    assert_text "Exam pager was successfully updated"
    click_on "Back"
  end

  test "destroying a Exam pager" do
    visit train_exam_pagers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Exam pager was successfully destroyed"
  end
end
