require 'test_helper'

class JournalTransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @journal_transfer = journal_transfers(:one)
  end

  test "should get index" do
    get journal_transfers_url
    assert_response :success
  end

  test "should get new" do
    get new_journal_transfer_url
    assert_response :success
  end

  test "should create journal_transfer" do
    assert_difference('JournalTransfer.count') do
      post journal_transfers_url, params: { journal_transfer: {  } }
    end

    assert_redirected_to journal_transfer_url(JournalTransfer.last)
  end

  test "should show journal_transfer" do
    get journal_transfer_url(@journal_transfer)
    assert_response :success
  end

  test "should get edit" do
    get edit_journal_transfer_url(@journal_transfer)
    assert_response :success
  end

  test "should update journal_transfer" do
    patch journal_transfer_url(@journal_transfer), params: { journal_transfer: {  } }
    assert_redirected_to journal_transfer_url(@journal_transfer)
  end

  test "should destroy journal_transfer" do
    assert_difference('JournalTransfer.count', -1) do
      delete journal_transfer_url(@journal_transfer)
    end

    assert_redirected_to journal_transfers_url
  end
end
