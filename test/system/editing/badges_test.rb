require "application_system_test_case"

class BadgesTest < ApplicationSystemTestCase
  setup do
    @editing_badge = editing_badges(:one)
  end

  test "visiting the index" do
    visit editing_badges_url
    assert_selector "h1", text: "Badges"
  end

  test "creating a Badge" do
    visit editing_badges_url
    click_on "New Badge"

    fill_in "Abbr", with: @editing_badge.abbr
    fill_in "Level", with: @editing_badge.level
    fill_in "Title", with: @editing_badge.title
    click_on "Create Badge"

    assert_text "Badge was successfully created"
    click_on "Back"
  end

  test "updating a Badge" do
    visit editing_badges_url
    click_on "Edit", match: :first

    fill_in "Abbr", with: @editing_badge.abbr
    fill_in "Level", with: @editing_badge.level
    fill_in "Title", with: @editing_badge.title
    click_on "Update Badge"

    assert_text "Badge was successfully updated"
    click_on "Back"
  end

  test "destroying a Badge" do
    visit editing_badges_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Badge was successfully destroyed"
  end
end
