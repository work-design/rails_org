module RailsOrg::Our
  extend ActiveSupport::Concern
  included do
    helper_method :current_organ
  end

  def current_organ
    return @current_organ if defined?(@current_organ)
    @current_organ = current_authorized_token&.organ
  end

  def require_organ
    return if current_organ

    if request.format.html?
      render 'require_organ', locals: { return_to: RailsOrg.config.default_return_path }, layout: 'application', status: 401
    else
      render 'require_organ', locals: { return_to: RailsOrg.config.default_return_path }, status: 401
    end
  end

end
