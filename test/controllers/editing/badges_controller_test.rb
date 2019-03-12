require 'test_helper'

class Editing::BadgesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @editing_badge = editing_badges(:one)
  end

  test "should get index" do
    get editing_badges_url
    assert_response :success
  end

  test "should get new" do
    get new_editing_badge_url
    assert_response :success
  end

  test "should create editing_badge" do
    assert_difference('Badge.count') do
      post editing_badges_url, params: { editing_badge: { abbr: @editing_badge.abbr, level: @editing_badge.level, title: @editing_badge.title } }
    end

    assert_redirected_to editing_badge_url(Badge.last)
  end

  test "should show editing_badge" do
    get editing_badge_url(@editing_badge)
    assert_response :success
  end

  test "should get edit" do
    get edit_editing_badge_url(@editing_badge)
    assert_response :success
  end

  test "should update editing_badge" do
    patch editing_badge_url(@editing_badge), params: { editing_badge: { abbr: @editing_badge.abbr, level: @editing_badge.level, title: @editing_badge.title } }
    assert_redirected_to editing_badge_url(@editing_badge)
  end

  test "should destroy editing_badge" do
    assert_difference('Badge.count', -1) do
      delete editing_badge_url(@editing_badge)
    end

    assert_redirected_to editing_badges_url
  end
end
