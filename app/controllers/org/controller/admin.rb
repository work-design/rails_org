module Org
  module Controller::Admin
    extend ActiveSupport::Concern

    def require_org_member
      return if current_member
      return if (current_organ.self_and_ancestor_ids & Array(current_user && current_user.members.pluck(:organ_id))).present?
      return if current_user&.admin?

      if current_user
        redirect_to controller: '/home'
      else
        require_user
      end
    end

  end
end
