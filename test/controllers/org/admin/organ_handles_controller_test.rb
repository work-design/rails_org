require 'test_helper'

class Org::Admin::OrganHandlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_admin_organ_handle = create org_admin_organ_handles
  end

  test 'index ok' do
    get admin_organ_handles_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_organ_handle_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('OrganHandle.count') do
      post admin_organ_handles_url, params: {  }
    end

    assert_redirected_to org_admin_organ_handle_url(OrganHandle.last)
  end

  test 'show ok' do
    get admin_organ_handle_url(@org_admin_organ_handle)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_organ_handle_url(@org_admin_organ_handle)
    assert_response :success
  end

  test 'update ok' do
    patch admin_organ_handle_url(@org_admin_organ_handle), params: {  }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('OrganHandle.count', -1) do
      delete admin_organ_handle_url(@org_admin_organ_handle)
    end

    assert_response :success
  end
end
