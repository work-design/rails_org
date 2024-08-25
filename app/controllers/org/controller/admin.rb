module Org
  module Controller::Admin
    extend ActiveSupport::Concern

    def require_org_member
      return if current_member
      return if current_organ && current_organ.self_and_ancestor_ids.include?(current_member&.organ_id)

      if current_authorized_token
        render 'require_org_member', layout: 'application'
      else
        require_user(current_provider_app)
      end
    end

  end
end
