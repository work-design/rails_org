class Org::Admin::BaseController < RailsOrg.config.admin_class.constantize
  before_action :require_organ

  def require_organ
    return if current_organ

    if api_request?
      raise ActionController::UnauthorizedError
    else
      redirect_to root_url
    end
  end

  def current_organ
    @current_organ ||= Organ.find_by(token: session[:organ_token])
  end

end
