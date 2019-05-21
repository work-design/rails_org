require 'test_helper'

class Org::Admin::OrgConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @org_admin_org_config = create org_admin_org_configs
  end

  test 'index ok' do
    get admin_org_configs_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_org_config_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('OrgConfig.count') do
      post admin_org_configs_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to org_admin_org_config_url(OrgConfig.last)
  end

  test 'show ok' do
    get admin_org_config_url(@org_admin_org_config)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_org_config_url(@org_admin_org_config)
    assert_response :success
  end

  test 'update ok' do
    patch admin_org_config_url(@org_admin_org_config), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to org_admin_org_config_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('OrgConfig.count', -1) do
      delete admin_org_config_url(@org_admin_org_config)
    end

    assert_redirected_to admin_org_configs_url
  end
end
