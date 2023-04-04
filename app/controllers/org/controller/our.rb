module Org
  module Controller::Our
    extend ActiveSupport::Concern

    included do
      before_action :require_client
    end

    def require_organ
      return if current_organ

      raise ActionController::RoutingError, 'Not Found'
    end

    def require_client
      return if current_client
      #redirect_to url_for(controller: 'trade/our/carts', action: 'list', **params.permit(:auth_token, :role_id))

      redirect_to url_for(controller: 'org/board/organs', **params.permit(:auth_token, :role_id))
    end

  end
end
