module RailsOrg::Me
  extend ActiveSupport::Concern

  included do
    helper_method :current_member
  end

  # Must order after RailsRole::Controller
  def rails_role_user
    if current_organ && current_member
      current_member
    else
      super
    end
  end

  def current_member
    return @current_member if defined?(@current_member)

    @current_member = current_authorized_token.members.find_by(organ_id: current_organ&.id)
    logger.debug "  ==========> Login as member: #{@current_member&.id}"
    @current_member
  end

  def require_member
    return if current_member

    if request.format.html?
      render 'require_member', locals: { return_to: RailsOrg.config.default_return_path }, layout: 'application', status: 401
    else
      render 'require_member', locals: { return_to: RailsOrg.config.default_return_path }, status: 401
    end
  end

end
