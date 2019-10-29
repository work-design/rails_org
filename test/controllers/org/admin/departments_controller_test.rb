require 'test_helper'
class Org::Admin::DepartmentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @department = create :department
  end

  test 'index ok' do
    get admin_departments_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_department_url, xhr: true
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Department.count') do
      post admin_departments_url, params: { department: { name: '研发部' } }, xhr: true
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_department_url(@department)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_department_url(@department), xhr: true
    assert_response :success
  end

  test 'update ok' do
    patch admin_department_url(@department), params: { department: { name: '董事会' } }, xhr: true
    
    @department.reload
    assert_equal '董事会', @department.name
    assert_response :success
  end

  test 'destroy department' do
    assert_difference('Department.count', -1) do
      delete admin_department_url(@department), xhr: true
    end

    assert_response :success
  end
end
