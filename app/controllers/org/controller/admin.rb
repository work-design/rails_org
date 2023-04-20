module Org
  module Controller::Admin
    extend ActiveSupport::Concern

    # Must order after RailsRole::Controller
    def rails_role_user
      return @rails_role_user if defined? @rails_role_user
      r = (current_organ.self_and_ancestor_ids & current_account.organ_ids)
      if r.present?
        @rails_role_user = current_account.members.where(organ_id: r).take
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
