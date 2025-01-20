module Org
  class Admin::AuthorizedTokensController < Admin::BaseController
    before_action :set_member
    before_action :set_authorized_token, only: [:show, :edit, :update, :destroy]

    def index
      @authorized_tokens = @member.authorized_tokens
    end

    private
    def set_member
      @member = Member.find params[:member_id]
    end

    def set_authorized_token
      @authorized_token = AuthorizedToken.find(params[:id])
    end

    def authorized_token_params
      params.fetch(:authorized_token, {}).permit(
        :user_id,
        :oauth_user_id,
        :token,
        :expire_at,
        :mock_member
      )
    end

  end
end
