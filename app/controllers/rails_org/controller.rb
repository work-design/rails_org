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

  def rails_role_user
    if organ_grant
      organ_grant
    else
      current_user
    end
  end

  def current_organ_grant
    return @organ_grant if defined?(@organ_grant)
    @organ_grant = login_from_organ_token
  end

  def current_member
    return @current_member if defined?(@current_member)
    @current_member = current_organ_grant.member
  end

  def current_organ
    return @current_organ if defined?(@current_organ)
    @current_organ = current_organ_grant.organ
  end

  def login_from_organ_token
    organ_token = request.headers['Organ-Token'].presence || session[:organ_token]
    @organ_grant = ::OrganGrant.find_by(token: organ_token)
  end

  def other_organs
    current_user.organs.where.not(id: current_organ.id)
  end

  def login_organ_as(organ_grant)
    unless api_request?
      session[:organ_token] = organ_grant.token
    end

    logger.debug "Login as Organ #{organ_grant.organ_id}"

    @current_organ = organ_grant.organ
  end

  def set_organ_token
    return unless current_organ_grant

    if api_request?
      headers['Organ-Token'] = current_organ_grant.token
    else
      session[:organ_token] = current_organ_grant.token
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
