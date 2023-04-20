module Org
  module Controller::Admin
    extend ActiveSupport::Concern

    # Must order after RailsRole::Controller
    def rails_role_user
      if current_organ && current_member
        current_member
      else
        super
      end
    end

    def require_org_member
      return if (current_organ.self_and_ancestor_ids & current_account.organ_ids).present?

      if request.format.html?
        render 'require_member', locals: { return_to: RailsOrg.config.default_return_path }, layout: 'application', status: 401
      else
        render 'require_member', locals: { return_to: RailsOrg.config.default_return_path }, status: 401
      end
    end

  end
end
