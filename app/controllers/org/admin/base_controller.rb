class Org::Admin::BaseController < RailsOrg.config.admin_class.constantize
  before_action :require_organ

  def require_organ
    binding.pry
    return if current_organ

    raise ActionController::UnauthorizedError
  end

  def current_organ
    binding.pry
    @current_organ ||= Organ.find_by(token: session[:organ_token])
  end

end
