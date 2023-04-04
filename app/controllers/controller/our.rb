# frozen_string_literal: true

module Org
  module Controller::Our
    extend ActiveSupport::Concern

    included do
      before_action :require_client
    end

    def require_client
      return if current_client

      redirect_to url_for(controller: 'org/board/organs', **params.permit(:auth_token))
    end

  end
end
