require 'test_helper'

class Org::My::TeachersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_teacher = my_teachers(:one)
  end

  test "should get index" do
    get my_teachers_url
    assert_response :success
  end

  test "should get new" do
    get new_my_teacher_url
    assert_response :success
  end

  test "should create my_teacher" do
    assert_difference('Teacher.count') do
      post my_teachers_url, params: { my_teacher: {  } }
    end

    assert_redirected_to my_teacher_url(Teacher.last)
  end

  test "should show my_teacher" do
    get my_teacher_url(@my_teacher)
    assert_response :success
  end

  test "should get edit" do
    get edit_my_teacher_url(@my_teacher)
    assert_response :success
  end

  test "should update my_teacher" do
    patch my_teacher_url(@my_teacher), params: { my_teacher: {  } }
    assert_redirected_to my_teacher_url(@my_teacher)
  end

  test "should destroy my_teacher" do
    assert_difference('Teacher.count', -1) do
      delete my_teacher_url(@my_teacher)
    end

    assert_redirected_to my_teachers_url
  end
end
