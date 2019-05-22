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

  def current_organ
    return @current_organ if defined?(@current_organ)
    @current_organ, _ = login_from_organ_token
    @current_organ
  end

  def current_member
    return @current_member if defined?(@current_member)
    _, @current_member = login_from_organ_token
    @current_member
  end

  def login_from_organ_token
    organ_token = request.headers['Organ-Token'].presence || session[:organ_token]
    organ_grant = ::OrganGrant.find_by(token: organ_token)
    if organ_grant
      @current_organ = organ_grant.organ
      @current_member = organ_grant.member
      [@current_organ, @current_member]
    else
      [nil, nil]
    end
  end

  def other_organs
    current_user.organs.where.not(id: current_organ.id)
  end

  def login_organ_as(organ_token)
    unless api_request?
      session[:organ_token] = organ_token.token
    end

    logger.debug "Login as Organ #{organ_token.organ_id}"

    @current_member = organ_token.member
    @current_organ = organ_token.organ
  end

  def set_organ_token
    return unless current_organ && current_member
    organ_token = current_member.get_organ_token(current_organ.id)

    if api_request?
      headers['Organ-Token'] = organ_token.token
    else
      session[:organ_token] = organ_token.token
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
