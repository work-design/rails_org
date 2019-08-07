module RailsOrg::OrgController
  extend ActiveSupport::Concern
  included do
    helper_method :current_organ
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
  
  def current_receiver
    if current_member
      current_member
    else
      current_user
    end
  end

  def current_organ
    return @current_organ if defined?(@current_organ)
    @current_organ = login_from_organ_token
  end

  def login_from_organ_token
    organ_token = request.headers['Organ-Token'].presence || session[:organ_token]
    return unless organ_token
    @current_organ_token = ::OrganToken.find_by(token: organ_token)
    if @current_organ_token
      @current_organ = @current_organ_token.organ
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

  def login_organ_as(organ_token)
    unless api_request?
      session[:organ_token] = organ_token.token
    end

    logger.debug "  ==========> Login as Organ #{organ_token.organ_id}"
    
    @current_organ_token = organ_token
  end

  def set_organ_token
    if defined?(@current_organ_token)
      token = @current_organ_token.token
    else
      return
    end

    if api_request?
      headers['Organ-Token'] = token
    else
      session[:organ_token] = token
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

  def organ_ancestors_params
    if current_organ
      { organ_id: current_organ.self_and_ancestor_ids }
    else
      default_params
    end
  end

  def organ_descendants_params
    if current_organ
      { organ_id: current_organ.self_and_descendant_ids }
    else
      default_params
    end
  end

end
