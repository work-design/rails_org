require 'test_helper'
class Org::Admin::AuthorizedTokensControllerTest < ActionDispatch::IntegrationTest

  setup do
    @org_admin_authorized_token = create org_admin_authorized_tokens
  end

  test 'index ok' do
    get admin_authorized_tokens_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_authorized_token_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('AuthorizedToken.count') do
      post admin_authorized_tokens_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_authorized_token_url(@org_admin_authorized_token)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_authorized_token_url(@org_admin_authorized_token)
    assert_response :success
  end

  test 'update ok' do
    patch admin_authorized_token_url(@org_admin_authorized_token), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('AuthorizedToken.count', -1) do
      delete admin_authorized_token_url(@org_admin_authorized_token)
    end

    assert_response :success
  end

end
