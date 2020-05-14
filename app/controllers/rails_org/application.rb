module RailsOrg::Application
  extend ActiveSupport::Concern
  included do
    helper_method :current_session_organ, :current_member, :other_organs
  end

  def current_title
    if current_session_organ
      current_session_organ.name
    else
      t('.title', default: :site_name)
    end
  end

  def require_member
    return if current_member

    if request.format.html?
      render 'require_member', locals: { return_to: RailsOrg.config.default_return_path }, layout: 'application', status: 401
    else
      render 'require_member', locals: { return_to: RailsOrg.config.default_return_path }, status: 401
    end
  end

  # Must order after RailsRole::Controller
  def rails_role_user
    if current_member
      current_member
    else
      current_user
    end
  end

  def current_session_organ
    return @current_session_organ if defined?(@current_session_organ)
    sd = request.subdomains
    if sd.size == 2 && sd[1] == RailsOrg.config.subdomain
      @current_session_organ = Organ.find_by(code: sd[0])
    end
  end

  def current_member
    return @current_member if defined?(@current_member)
    @current_member = current_authorized_token&.member
  end

  def other_organs
    current_user.organs.where.not(id: current_session_organ.id)
  end

  # Must order after RailsAuth::Controller
  def login_by_account(account)
    super
    if account.members.size == 1
      @current_member = account.members.first
      @current_authorized_token = @current_member.get_organ_grant
      logger.debug "  ==========> Login by account as member: #{@current_member.id}"
    else
      @current_authorized_token = account.authorized_token
      logger.debug "  ==========> There are more than one organs, please goto select one;"
    end
  end

  def login_organ_as(organ_grant)
    logger.debug "  ==========> Login as Organ #{organ_grant.organ_id}"
    @current_authorized_token = organ_grant
  end

  def default_params
    if current_session_organ
      { organ_id: current_session_organ.id }
    else
      super
    end
  end

  def default_form_params
    if current_session_organ
      { organ_id: current_session_organ.id }
    else
      super
    end
  end

end
