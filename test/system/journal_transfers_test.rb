require "application_system_test_case"

class JournalTransfersTest < ApplicationSystemTestCase
  setup do
    @journal_transfer = journal_transfers(:one)
  end

  test "visiting the index" do
    visit journal_transfers_url
    assert_selector "h1", text: "Journal Transfers"
  end

  test "creating a Journal transfer" do
    visit journal_transfers_url
    click_on "New Journal Transfer"

    click_on "Create Journal transfer"

    assert_text "Journal transfer was successfully created"
    click_on "Back"
  end

  test "updating a Journal transfer" do
    visit journal_transfers_url
    click_on "Edit", match: :first

    click_on "Update Journal transfer"

    assert_text "Journal transfer was successfully updated"
    click_on "Back"
  end

  test "destroying a Journal transfer" do
    visit journal_transfers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Journal transfer was successfully destroyed"
  end
end
