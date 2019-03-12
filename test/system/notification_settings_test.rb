require "application_system_test_case"

class NotificationSettingsTest < ApplicationSystemTestCase
  setup do
    @notification_setting = notification_settings(:one)
  end

  test "visiting the index" do
    visit notification_settings_url
    assert_selector "h1", text: "Notification Settings"
  end

  test "creating a Notification setting" do
    visit notification_settings_url
    click_on "New Notification Setting"

    click_on "Create Notification setting"

    assert_text "Notification setting was successfully created"
    click_on "Back"
  end

  test "updating a Notification setting" do
    visit notification_settings_url
    click_on "Edit", match: :first

    click_on "Update Notification setting"

    assert_text "Notification setting was successfully updated"
    click_on "Back"
  end

  test "destroying a Notification setting" do
    visit notification_settings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Notification setting was successfully destroyed"
  end
end
