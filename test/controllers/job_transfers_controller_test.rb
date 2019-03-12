require 'test_helper'

class JobTransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_transfer = job_transfers(:one)
  end

  test "should get index" do
    get job_transfers_url
    assert_response :success
  end

  test "should get new" do
    get new_job_transfer_url
    assert_response :success
  end

  test "should create job_transfer" do
    assert_difference('JobTransfer.count') do
      post job_transfers_url, params: { job_transfer: {  } }
    end

    assert_redirected_to job_transfer_url(JobTransfer.last)
  end

  test "should show job_transfer" do
    get job_transfer_url(@job_transfer)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_transfer_url(@job_transfer)
    assert_response :success
  end

  test "should update job_transfer" do
    patch job_transfer_url(@job_transfer), params: { job_transfer: {  } }
    assert_redirected_to job_transfer_url(@job_transfer)
  end

  test "should destroy job_transfer" do
    assert_difference('JobTransfer.count', -1) do
      delete job_transfer_url(@job_transfer)
    end

    assert_redirected_to job_transfers_url
  end
end
