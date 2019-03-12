require "application_system_test_case"

class PurchaseTaxonsTest < ApplicationSystemTestCase
  setup do
    @purchase_taxon = purchase_taxons(:one)
  end

  test "visiting the index" do
    visit purchase_taxons_url
    assert_selector "h1", text: "Purchase Taxons"
  end

  test "creating a Purchase taxon" do
    visit purchase_taxons_url
    click_on "New Purchase Taxon"

    click_on "Create Purchase taxon"

    assert_text "Purchase taxon was successfully created"
    click_on "Back"
  end

  test "updating a Purchase taxon" do
    visit purchase_taxons_url
    click_on "Edit", match: :first

    click_on "Update Purchase taxon"

    assert_text "Purchase taxon was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase taxon" do
    visit purchase_taxons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase taxon was successfully destroyed"
  end
end
