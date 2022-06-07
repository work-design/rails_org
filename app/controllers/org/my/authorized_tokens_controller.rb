module Org
  class My::AuthorizedTokensController < My::BaseController
    before_action :set_authorized_token, only: [:update]

    private
    def set_authorized_token
      @authorized_token = current_authorized_token
    end

    def authorized_token_params
      params.permit(:member_id)
    end
  end
end
