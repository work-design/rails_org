module Org
  module Controller::Me
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

      redirect_to url_for(controller: 'org/board/organs', host: current_organ.provider.host, **params.permit(:auth_token)), allow_other_host: true
    end

  end
end
