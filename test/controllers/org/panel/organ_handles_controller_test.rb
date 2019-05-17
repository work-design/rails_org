require 'test_helper'

class Org::Panel::OrganHandlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_panel_organ_handle = create org_panel_organ_handles
  end

  test 'index ok' do
    get panel_organ_handles_url
    assert_response :success
  end

  test 'new ok' do
    get new_panel_organ_handle_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('OrganHandle.count') do
      post panel_organ_handles_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to org_panel_organ_handle_url(OrganHandle.last)
  end

  test 'show ok' do
    get panel_organ_handle_url(@org_panel_organ_handle)
    assert_response :success
  end

  test 'edit ok' do
    get edit_panel_organ_handle_url(@org_panel_organ_handle)
    assert_response :success
  end

  test 'update ok' do
    patch panel_organ_handle_url(@org_panel_organ_handle), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to org_panel_organ_handle_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('OrganHandle.count', -1) do
      delete panel_organ_handle_url(@org_panel_organ_handle)
    end

    assert_redirected_to panel_organ_handles_url
  end
end
