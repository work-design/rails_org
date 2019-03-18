require "application_system_test_case"

class RoomsTest < ApplicationSystemTestCase
  setup do
    @org_panel_room = org_panel_rooms(:one)
  end

  test "visiting the index" do
    visit org_panel_rooms_url
    assert_selector "h1", text: "Rooms"
  end

  test "creating a Room" do
    visit org_panel_rooms_url
    click_on "New Room"

    fill_in "Room number", with: @org_panel_room.room_number
    fill_in "Time plans count", with: @org_panel_room.time_plans_count
    click_on "Create Room"

    assert_text "Room was successfully created"
    click_on "Back"
  end

  test "updating a Room" do
    visit org_panel_rooms_url
    click_on "Edit", match: :first

    fill_in "Room number", with: @org_panel_room.room_number
    fill_in "Time plans count", with: @org_panel_room.time_plans_count
    click_on "Update Room"

    assert_text "Room was successfully updated"
    click_on "Back"
  end

  test "destroying a Room" do
    visit org_panel_rooms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Room was successfully destroyed"
  end
end
