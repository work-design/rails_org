module RailsOrg::Controller
  extend ActiveSupport::Concern
  included do
    helper_method :current_organ, :current_member, :other_organs
    after_action :set_organ_token
  end

  def require_organ
    return if current_organ

    if api_request?
      raise ActionController::UnauthorizedError, 'Organ not login'
    else
      redirect_to RailsOrg.config.default_return_path
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
  
  def current_receiver
    if current_member
      current_member
    else
      current_user
    end
  end

  def current_member
    return @current_member if defined?(@current_member)
    @current_member, _ = login_from_organ_token
    @current_member
  end

  def current_organ
    return @current_organ if defined?(@current_organ)
    _, @current_organ = login_from_organ_token
    @current_organ
  end

  def login_from_organ_token
    organ_token = request.headers['Organ-Token'].presence || session[:organ_token]
    return unless organ_token
    organ_grant = ::OrganGrant.find_by(token: organ_token)
    if organ_grant
      @current_member, @current_organ = organ_grant.member, organ_grant.organ
    end
  end

  def other_organs
    current_user.organs.where.not(id: current_organ.id)
  end
  
  # Must order after RailsAuth::Controller
  def login_by_account(account)
    super
    if account.members.size == 1
      @current_member = account.members.first
      @current_organ = @current_member.organ
      logger.debug "  ==========> Login by account as member: #{@current_member.id}"
    else
      logger.debug "  ==========> There are more than one organs, please goto select one;"
    end
  end

  def login_organ_as(organ_grant)
    unless api_request?
      session[:organ_token] = organ_grant.token
    end

    logger.debug "  ==========> Login as Organ #{organ_grant.organ_id}"

    @current_organ = organ_grant.organ
  end

  def set_organ_token
    return unless current_member

    if api_request?
      headers['Organ-Token'] = current_member.get_organ_grant.token
    else
      session[:organ_token] = current_member.get_organ_grant.token
    end
  end

  def api_request?
    request.headers['Organ-Token'].present? || request.format.json?
  end

  def default_params
    if current_organ
      { organ_id: current_organ.id }
    else
      super
    end
  end

end
