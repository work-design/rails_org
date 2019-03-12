require "application_system_test_case"

class ExpenseMembersTest < ApplicationSystemTestCase
  setup do
    @finance_expense_member = finance_expense_members(:one)
  end

  test "visiting the index" do
    visit finance_expense_members_url
    assert_selector "h1", text: "Expense Members"
  end

  test "creating a Expense member" do
    visit finance_expense_members_url
    click_on "New Expense Member"

    click_on "Create Expense member"

    assert_text "Expense member was successfully created"
    click_on "Back"
  end

  test "updating a Expense member" do
    visit finance_expense_members_url
    click_on "Edit", match: :first

    click_on "Update Expense member"

    assert_text "Expense member was successfully updated"
    click_on "Back"
  end

  test "destroying a Expense member" do
    visit finance_expense_members_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Expense member was successfully destroyed"
  end
end
