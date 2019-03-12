require "application_system_test_case"

class LessonMembersTest < ApplicationSystemTestCase
  setup do
    @lesson_member = lesson_members(:one)
  end

  test "visiting the index" do
    visit lesson_members_url
    assert_selector "h1", text: "Lesson Members"
  end

  test "creating a Lesson member" do
    visit lesson_members_url
    click_on "New Lesson Member"

    click_on "Create Lesson member"

    assert_text "Lesson member was successfully created"
    click_on "Back"
  end

  test "updating a Lesson member" do
    visit lesson_members_url
    click_on "Edit", match: :first

    click_on "Update Lesson member"

    assert_text "Lesson member was successfully updated"
    click_on "Back"
  end

  test "destroying a Lesson member" do
    visit lesson_members_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lesson member was successfully destroyed"
  end
end
