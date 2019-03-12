require "application_system_test_case"

class LessonTaxonsTest < ApplicationSystemTestCase
  setup do
    @lesson_taxon = lesson_taxons(:one)
  end

  test "visiting the index" do
    visit lesson_taxons_url
    assert_selector "h1", text: "Lesson Taxons"
  end

  test "creating a Lesson taxon" do
    visit lesson_taxons_url
    click_on "New Lesson Taxon"

    click_on "Create Lesson taxon"

    assert_text "Lesson taxon was successfully created"
    click_on "Back"
  end

  test "updating a Lesson taxon" do
    visit lesson_taxons_url
    click_on "Edit", match: :first

    click_on "Update Lesson taxon"

    assert_text "Lesson taxon was successfully updated"
    click_on "Back"
  end

  test "destroying a Lesson taxon" do
    visit lesson_taxons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lesson taxon was successfully destroyed"
  end
end
