require "application_system_test_case"

class CheckSettingsTest < ApplicationSystemTestCase
  setup do
    @hr_check_setting = admin_check_settings(:one)
  end

  test "visiting the index" do
    visit admin_check_settings_url
    assert_selector "h1", text: "Check Settings"
  end

  test "creating a Check setting" do
    visit admin_check_settings_url
    click_on "New Check Setting"

    click_on "Create Check setting"

    assert_text "Check setting was successfully created"
    click_on "Back"
  end

  test "updating a Check setting" do
    visit admin_check_settings_url
    click_on "Edit", match: :first

    click_on "Update Check setting"

    assert_text "Check setting was successfully updated"
    click_on "Back"
  end

  test "destroying a Check setting" do
    visit admin_check_settings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Check setting was successfully destroyed"
  end
end
