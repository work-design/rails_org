require 'test_helper'

class PurchaseTaxonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase_taxon = purchase_taxons(:one)
  end

  test "should get index" do
    get purchase_taxons_url
    assert_response :success
  end

  test "should get new" do
    get new_purchase_taxon_url
    assert_response :success
  end

  test "should create purchase_taxon" do
    assert_difference('PurchaseTaxon.count') do
      post purchase_taxons_url, params: { purchase_taxon: {  } }
    end

    assert_redirected_to purchase_taxon_url(PurchaseTaxon.last)
  end

  test "should show purchase_taxon" do
    get purchase_taxon_url(@purchase_taxon)
    assert_response :success
  end

  test "should get edit" do
    get edit_purchase_taxon_url(@purchase_taxon)
    assert_response :success
  end

  test "should update purchase_taxon" do
    patch purchase_taxon_url(@purchase_taxon), params: { purchase_taxon: {  } }
    assert_redirected_to purchase_taxon_url(@purchase_taxon)
  end

  test "should destroy purchase_taxon" do
    assert_difference('PurchaseTaxon.count', -1) do
      delete purchase_taxon_url(@purchase_taxon)
    end

    assert_redirected_to purchase_taxons_url
  end
end
