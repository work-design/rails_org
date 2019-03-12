require 'test_helper'

class Train::ExamPagersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @train_exam_pager = train_exam_pagers(:one)
  end

  test "should get index" do
    get train_exam_pagers_url
    assert_response :success
  end

  test "should get new" do
    get new_train_exam_pager_url
    assert_response :success
  end

  test "should create train_exam_pager" do
    assert_difference('ExamPager.count') do
      post train_exam_pagers_url, params: { train_exam_pager: { description: @train_exam_pager.description, title: @train_exam_pager.title } }
    end

    assert_redirected_to train_exam_pager_url(ExamPager.last)
  end

  test "should show train_exam_pager" do
    get train_exam_pager_url(@train_exam_pager)
    assert_response :success
  end

  test "should get edit" do
    get edit_train_exam_pager_url(@train_exam_pager)
    assert_response :success
  end

  test "should update train_exam_pager" do
    patch train_exam_pager_url(@train_exam_pager), params: { train_exam_pager: { description: @train_exam_pager.description, title: @train_exam_pager.title } }
    assert_redirected_to train_exam_pager_url(@train_exam_pager)
  end

  test "should destroy train_exam_pager" do
    assert_difference('ExamPager.count', -1) do
      delete train_exam_pager_url(@train_exam_pager)
    end

    assert_redirected_to train_exam_pagers_url
  end
end
