module RailsOrg::Our
  extend ActiveSupport::Concern

  def require_organ
    return if current_organ

    raise ActionController::RoutingError, 'Not Found'
  end

end
