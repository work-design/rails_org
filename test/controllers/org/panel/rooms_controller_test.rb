require 'test_helper'

class Org::Panel::RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_panel_room = create org_panel_rooms
  end

  test 'index ok' do
    get panel_rooms_url
    assert_response :success
  end

  test 'new ok' do
    get new_panel_room_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Room.count') do
      post panel_rooms_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to org_panel_room_url(Room.last)
  end

  test 'show ok' do
    get panel_room_url(@org_panel_room)
    assert_response :success
  end

  test 'edit ok' do
    get edit_panel_room_url(@org_panel_room)
    assert_response :success
  end

  test 'update ok' do
    patch panel_room_url(@org_panel_room), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to org_panel_room_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('Room.count', -1) do
      delete panel_room_url(@org_panel_room)
    end

    assert_redirected_to panel_rooms_url
  end
end
