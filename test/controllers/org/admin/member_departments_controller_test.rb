require 'test_helper'

class Org::Admin::MemberDepartmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_admin_member_department = create org_admin_member_departments
  end

  test 'index ok' do
    get admin_member_departments_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_member_department_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('MemberDepartment.count') do
      post admin_member_departments_url, params: { }
    end

    assert_redirected_to org_admin_member_department_url(MemberDepartment.last)
  end

  test 'show ok' do
    get admin_member_department_url(@org_admin_member_department)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_member_department_url(@org_admin_member_department)
    assert_response :success
  end

  test 'update ok' do
    patch admin_member_department_url(@org_admin_member_department), params: { }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('MemberDepartment.count', -1) do
      delete admin_member_department_url(@org_admin_member_department)
    end

    assert_response :success
  end
end
