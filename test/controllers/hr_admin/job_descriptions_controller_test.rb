require 'test_helper'

class Hr::JobDescriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_description = job_descriptions(:one)
  end

  test "should get index" do
    get job_descriptions_url
    assert_response :success
  end

  test "should get new" do
    get new_job_description_url
    assert_response :success
  end

  test "should create job_description" do
    assert_difference('JobDescription.count') do
      post job_descriptions_url, params: { job_description: {  } }
    end

    assert_redirected_to job_description_url(JobDescription.last)
  end

  test "should show job_description" do
    get job_description_url(@job_description)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_description_url(@job_description)
    assert_response :success
  end

  test "should update job_description" do
    patch job_description_url(@job_description), params: { job_description: {  } }
    assert_redirected_to job_description_url(@job_description)
  end

  test "should destroy job_description" do
    assert_difference('JobDescription.count', -1) do
      delete job_description_url(@job_description)
    end

    assert_redirected_to job_descriptions_url
  end
end
