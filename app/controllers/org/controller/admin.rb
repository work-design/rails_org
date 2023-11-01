module Org
  module Controller::Admin
    extend ActiveSupport::Concern

    def require_org_member
      return if current_member
      return if current_organ.self_and_ancestor_ids.include?(current_member&.organ_id)

      if current_authorized_token
        redirect_to controller: '/home'
      else
        require_user
      end
    end

  end
end
