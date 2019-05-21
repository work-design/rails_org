require 'test_helper'

class Org::Admin::RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_admin_room = create org_admin_rooms
  end

  test 'index ok' do
    get admin_rooms_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_room_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Room.count') do
      post admin_rooms_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to org_admin_room_url(Room.last)
  end

  test 'show ok' do
    get admin_room_url(@org_admin_room)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_room_url(@org_admin_room)
    assert_response :success
  end

  test 'update ok' do
    patch admin_room_url(@org_admin_room), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to org_admin_room_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('Room.count', -1) do
      delete admin_room_url(@org_admin_room)
    end

    assert_redirected_to admin_rooms_url
  end
end
