class Org::Admin::BaseController < RailsOrg.config.admin_class.constantize
  before_action :require_organ
  before_action :require_role

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
