require 'test_helper'
class Org::Admin::SuperJobTitlesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @super_job_title = create :super_job_title
  end

  test 'index ok' do
    get admin_super_job_titles_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_super_job_title_url, xhr: true
    assert_response :success
  end

  test 'create ok' do
    assert_difference('SuperJobTitle.count') do
      post admin_super_job_titles_url, params: { super_job_title: { name: 'test' } }, xhr: true
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_super_job_title_url(@super_job_title), xhr: true
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_super_job_title_url(@super_job_title), xhr: true
    assert_response :success
  end

  test 'update ok' do
    patch admin_super_job_title_url(@super_job_title), params: { super_job_title: { name: '副总' } }, xhr: true
    
    @super_job_title.reload
    assert_equal '副总', @super_job_title.name
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('SuperJobTitle.count', -1) do
      delete admin_super_job_title_url(@super_job_title), xhr: true
    end

    assert_response :success
  end
end
