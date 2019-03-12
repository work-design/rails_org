require 'test_helper'

class LessonMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lesson_member = lesson_members(:one)
  end

  test "should get index" do
    get lesson_members_url
    assert_response :success
  end

  test "should get new" do
    get new_lesson_member_url
    assert_response :success
  end

  test "should create lesson_member" do
    assert_difference('LessonMember.count') do
      post lesson_members_url, params: { lesson_member: {  } }
    end

    assert_redirected_to lesson_member_url(LessonMember.last)
  end

  test "should show lesson_member" do
    get lesson_member_url(@lesson_member)
    assert_response :success
  end

  test "should get edit" do
    get edit_lesson_member_url(@lesson_member)
    assert_response :success
  end

  test "should update lesson_member" do
    patch lesson_member_url(@lesson_member), params: { lesson_member: {  } }
    assert_redirected_to lesson_member_url(@lesson_member)
  end

  test "should destroy lesson_member" do
    assert_difference('LessonMember.count', -1) do
      delete lesson_member_url(@lesson_member)
    end

    assert_redirected_to lesson_members_url
  end
end
