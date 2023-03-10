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

    def require_member(url: url_for(controller: 'org/board/organs'))
      return if current_member

      redirect_to url
    end

  end
end
