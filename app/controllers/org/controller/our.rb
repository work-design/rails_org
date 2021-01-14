module Org
  module Controller::Our
    extend ActiveSupport::Concern

    def require_organ
      return if current_organ

      raise ActionController::RoutingError, 'Not Found'
    end

  end
end
