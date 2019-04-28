require 'test_helper'

class Org::Panel::MemberDepartmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_panel_member_department = create org_panel_member_departments
  end

  test 'index ok' do
    get panel_member_departments_url
    assert_response :success
  end

  test 'new ok' do
    get new_panel_member_department_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('MemberDepartment.count') do
      post panel_member_departments_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to org_panel_member_department_url(MemberDepartment.last)
  end

  test 'show ok' do
    get panel_member_department_url(@org_panel_member_department)
    assert_response :success
  end

  test 'edit ok' do
    get edit_panel_member_department_url(@org_panel_member_department)
    assert_response :success
  end

  test 'update ok' do
    patch panel_member_department_url(@org_panel_member_department), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to org_panel_member_department_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('MemberDepartment.count', -1) do
      delete panel_member_department_url(@org_panel_member_department)
    end

    assert_redirected_to panel_member_departments_url
  end
end
