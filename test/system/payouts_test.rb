require "application_system_test_case"

class PayoutsTest < ApplicationSystemTestCase
  setup do
    @payout = payouts(:one)
  end

  test "visiting the index" do
    visit payouts_url
    assert_selector "h1", text: "Payouts"
  end

  test "creating a Payout" do
    visit payouts_url
    click_on "New Payout"

    click_on "Create Payout"

    assert_text "Payout was successfully created"
    click_on "Back"
  end

  test "updating a Payout" do
    visit payouts_url
    click_on "Edit", match: :first

    click_on "Update Payout"

    assert_text "Payout was successfully updated"
    click_on "Back"
  end

  test "destroying a Payout" do
    visit payouts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payout was successfully destroyed"
  end
end
