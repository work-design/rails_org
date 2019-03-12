require "application_system_test_case"

class ExtraDaysTest < ApplicationSystemTestCase
  setup do
    @extra_day = extra_days(:one)
  end

  test "visiting the index" do
    visit extra_days_url
    assert_selector "h1", text: "Extra Days"
  end

  test "creating a Extra day" do
    visit extra_days_url
    click_on "New Extra Day"

    click_on "Create Extra day"

    assert_text "Extra day was successfully created"
    click_on "Back"
  end

  test "updating a Extra day" do
    visit extra_days_url
    click_on "Edit", match: :first

    click_on "Update Extra day"

    assert_text "Extra day was successfully updated"
    click_on "Back"
  end

  test "destroying a Extra day" do
    visit extra_days_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Extra day was successfully destroyed"
  end
end
