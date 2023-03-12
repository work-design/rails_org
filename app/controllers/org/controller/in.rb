module Org
  module Controller::In
    extend ActiveSupport::Concern

    # Must order after RailsRole::Controller
    def rails_role_user
      if current_organ && current_member
        current_member
      else
        super
      end
    end

    def require_member
      return if current_member

      redirect_to url_for(controller: 'factory/in/home', action: 'organs', **params.permit(:auth_token))
    end

  end
end
