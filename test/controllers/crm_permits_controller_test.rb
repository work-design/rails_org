require 'test_helper'

class CrmPermitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crm_permit = crm_permits(:one)
  end

  test "should get index" do
    get crm_permits_url
    assert_response :success
  end

  test "should get new" do
    get new_crm_permit_url
    assert_response :success
  end

  test "should create crm_permit" do
    assert_difference('CrmPermit.count') do
      post crm_permits_url, params: { crm_permit: {  } }
    end

    assert_redirected_to crm_permit_url(CrmPermit.last)
  end

  test "should show crm_permit" do
    get crm_permit_url(@crm_permit)
    assert_response :success
  end

  test "should get edit" do
    get edit_crm_permit_url(@crm_permit)
    assert_response :success
  end

  test "should update crm_permit" do
    patch crm_permit_url(@crm_permit), params: { crm_permit: {  } }
    assert_redirected_to crm_permit_url(@crm_permit)
  end

  test "should destroy crm_permit" do
    assert_difference('CrmPermit.count', -1) do
      delete crm_permit_url(@crm_permit)
    end

    assert_redirected_to crm_permits_url
  end
end
