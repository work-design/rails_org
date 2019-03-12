require "application_system_test_case"

class FinancialMonthsTest < ApplicationSystemTestCase
  setup do
    @financial_month = financial_months(:one)
  end

  test "visiting the index" do
    visit financial_months_url
    assert_selector "h1", text: "Financial Months"
  end

  test "creating a Financial month" do
    visit financial_months_url
    click_on "New Financial Month"

    click_on "Create Financial month"

    assert_text "Financial month was successfully created"
    click_on "Back"
  end

  test "updating a Financial month" do
    visit financial_months_url
    click_on "Edit", match: :first

    click_on "Update Financial month"

    assert_text "Financial month was successfully updated"
    click_on "Back"
  end

  test "destroying a Financial month" do
    visit financial_months_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Financial month was successfully destroyed"
  end
end
