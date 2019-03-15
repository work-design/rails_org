module RailsOrgController
  extend ActiveSupport::Concern
  included do
    before_action :require_organ, :require_role
    helper_method :current_organ, :other_organs
  end

  def require_organ
    return if current_organ

    if api_request?
      raise ActionController::UnauthorizedError
    else
      redirect_to root_url
    end
  end

  def current_organ
    return @current_organ if defined?(@current_organ)
    token = OrganToken.find_by(token: session[:organ_token])
    @current_organ = token.organ if token
  end

  def current_member
    current_user.members.find_by(organ_id: current_organ.id)
  end

  def other_organs
    current_user.organs.where.not(id: current_organ.id)
  end

  def rails_role_user
    if current_user.admin?
      current_user
    else
      current_member
    end
  end

  def default_params
    q = {}.with_indifferent_access
    q.merge! organ_id: current_organ.id
    q
  end

end
