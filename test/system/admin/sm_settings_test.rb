require "application_system_test_case"

class SmSettingsTest < ApplicationSystemTestCase
  setup do
    @admin_sm_setting = admin_sm_settings(:one)
  end

  test "visiting the index" do
    visit admin_sm_settings_url
    assert_selector "h1", text: "Sm Settings"
  end

  test "creating a Sm setting" do
    visit admin_sm_settings_url
    click_on "New Sm Setting"

    click_on "Create Sm setting"

    assert_text "Sm setting was successfully created"
    click_on "Back"
  end

  test "updating a Sm setting" do
    visit admin_sm_settings_url
    click_on "Edit", match: :first

    click_on "Update Sm setting"

    assert_text "Sm setting was successfully updated"
    click_on "Back"
  end

  test "destroying a Sm setting" do
    visit admin_sm_settings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sm setting was successfully destroyed"
  end
end
