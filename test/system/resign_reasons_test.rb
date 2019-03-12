require "application_system_test_case"

class ResignReasonsTest < ApplicationSystemTestCase
  setup do
    @resign_reason = resign_reasons(:one)
  end

  test "visiting the index" do
    visit resign_reasons_url
    assert_selector "h1", text: "Resign Reasons"
  end

  test "creating a Resign reason" do
    visit resign_reasons_url
    click_on "New Resign Reason"

    click_on "Create Resign reason"

    assert_text "Resign reason was successfully created"
    click_on "Back"
  end

  test "updating a Resign reason" do
    visit resign_reasons_url
    click_on "Edit", match: :first

    click_on "Update Resign reason"

    assert_text "Resign reason was successfully updated"
    click_on "Back"
  end

  test "destroying a Resign reason" do
    visit resign_reasons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Resign reason was successfully destroyed"
  end
end
