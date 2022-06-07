require 'test_helper'
class Org::My::AuthorizedTokensControllerTest < ActionDispatch::IntegrationTest

  setup do
    @authorized_token = authorized_tokens(:one)
  end

  test 'index ok' do
    get url_for(controller: 'org/my/authorized_tokens')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'org/my/authorized_tokens')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('AuthorizedToken.count') do
      post(
        url_for(controller: 'org/my/authorized_tokens', action: 'create'),
        params: { authorized_token: { member_id: @org_my_authorized_token.member_id, user_id: @org_my_authorized_token.user_id } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'org/my/authorized_tokens', action: 'show', id: @authorized_token.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'org/my/authorized_tokens', action: 'edit', id: @authorized_token.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'org/my/authorized_tokens', action: 'update', id: @authorized_token.id),
      params: { authorized_token: { member_id: @org_my_authorized_token.member_id, user_id: @org_my_authorized_token.user_id } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('AuthorizedToken.count', -1) do
      delete url_for(controller: 'org/my/authorized_tokens', action: 'destroy', id: @authorized_token.id), as: :turbo_stream
    end

    assert_response :success
  end

end
