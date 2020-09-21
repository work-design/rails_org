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

  def current_organ
    return @current_organ if defined?(@current_organ)

    if request.subdomain.start_with? /org-|app-/
      @current_organ = current_domain_organ
    else
      @current_organ = current_official_organ
    end
    @current_organ = current_member&.organ if @current_organ.nil?
    logger.debug "  ==========> Login as organ: #{@current_organ&.name}"
    @current_organ
  end

  def current_member
    return @current_member if defined?(@current_member)
    if params[:member_id]
      m = current_user.members.find_by(id: params[:member_id])
      current_authorized_token.update member_id: m.id if m
    else
      m = current_account.members.find_by(organ_id: current_domain_organ&.id) || current_user.members.find_by(organ_id: current_domain_organ&.id)
    end
    @current_member = current_authorized_token&.member || m
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
