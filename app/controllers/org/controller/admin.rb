module Org
  module Controller::Admin
    extend ActiveSupport::Concern

    def current_member
      return @current_member if defined?(@current_member)

      @current_member = current_corp_user&.member || (current_user && current_user.members.where(organ_id: current_organ.self_and_ancestor_ids).take)
      logger.debug "\e[35m  Login as member: #{@current_member&.id}  \e[0m"
      @current_member
    end

    def require_org_member
      return if current_member
      return if (current_organ.self_and_ancestor_ids & Array(current_user && current_user.members.pluck(:organ_id))).present?
      return if current_user.admin?

      if current_user
        redirect_to controller: '/home'
      else
        require_user
      end
    end

  end
end
