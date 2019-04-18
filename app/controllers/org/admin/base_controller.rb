class Org::Admin::BaseController < RailsOrg.config.admin_controller.constantize
  before_action :require_role

  def rails_role_user
    if current_user.admin?
      current_user
    else
      current_user.members.first
    end
  end

  def default_params
    q = {}.with_indifferent_access
    q.merge! organ_id: current_organ.id
    q
  end

end
