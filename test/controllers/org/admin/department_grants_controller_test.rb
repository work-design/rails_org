require 'test_helper'

class Org::Admin::DepartmentGrantsControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @department_grant = create org_admin_department_grants
  end

  test 'index ok' do
    get admin_department_grants_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_department_grant_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('DepartmentGrant.count') do
      post admin_department_grants_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to org_admin_department_grant_url(DepartmentGrant.last)
  end

  test 'show ok' do
    get admin_department_grant_url(@org_admin_department_grant)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_department_grant_url(@org_admin_department_grant)
    assert_response :success
  end

  test 'update ok' do
    patch admin_department_grant_url(@org_admin_department_grant), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to org_admin_department_grant_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('DepartmentGrant.count', -1) do
      delete admin_department_grant_url(@org_admin_department_grant)
    end

    assert_redirected_to admin_department_grants_url
  end
end
