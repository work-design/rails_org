require 'test_helper'
class Org::Admin::JobTitlesControllerTest < ActionDispatch::IntegrationTest
 
  setup do
    @job_title = create :job_title
  end

  test 'index ok' do
    get admin_department_job_titles_url(@job_title.department_id)
    assert_response :success
  end

  test 'new ok' do
    get new_admin_department_job_title_url(@job_title.department_id), xhr: true
    assert_response :success
  end

  test 'create ok' do
    assert_difference('JobTitle.count') do
      post admin_department_job_titles_url(@job_title.department_id), params: { job_title: { name: '市场经理' } }, xhr: true
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_department_job_title_url(@job_title.department_id, @job_title), xhr: true
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_department_job_title_url(@job_title.department_id, @job_title), xhr: true
    assert_response :success
  end

  test 'update ok' do
    patch admin_department_job_title_url(@job_title.department_id, @job_title), params: { job_title: { name: '市场总监' } }, xhr: true
    
    @job_title.reload
    assert_equal '市场总监', @job_title.name
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('JobTitle.count', -1) do
      delete admin_department_job_title_url(@job_title.department_id, @job_title), xhr: true
    end

    assert_response :success
  end
end
