require 'test_helper'
class Org::Admin::OrganDomainsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @org_admin_organ_domain = create org_admin_organ_domains
  end

  test 'index ok' do
    get admin_organ_domains_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_organ_domain_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('OrganDomain.count') do
      post admin_organ_domains_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_organ_domain_url(@org_admin_organ_domain)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_organ_domain_url(@org_admin_organ_domain)
    assert_response :success
  end

  test 'update ok' do
    patch admin_organ_domain_url(@org_admin_organ_domain), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('OrganDomain.count', -1) do
      delete admin_organ_domain_url(@org_admin_organ_domain)
    end

    assert_response :success
  end

end
