require "application_system_test_case"

class CrmPermitsTest < ApplicationSystemTestCase
  setup do
    @crm_permit = crm_permits(:one)
  end

  test "visiting the index" do
    visit crm_permits_url
    assert_selector "h1", text: "Crm Permits"
  end

  test "creating a Crm permit" do
    visit crm_permits_url
    click_on "New Crm Permit"

    click_on "Create Crm permit"

    assert_text "Crm permit was successfully created"
    click_on "Back"
  end

  test "updating a Crm permit" do
    visit crm_permits_url
    click_on "Edit", match: :first

    click_on "Update Crm permit"

    assert_text "Crm permit was successfully updated"
    click_on "Back"
  end

  test "destroying a Crm permit" do
    visit crm_permits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Crm permit was successfully destroyed"
  end
end
