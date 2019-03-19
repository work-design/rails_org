module RailsOrgController
  extend ActiveSupport::Concern
  included do
    before_action :require_organ, :require_role
    helper_method :current_organ, :other_organs
    after_action :set_organ_token
  end

  def require_organ
    return if current_organ

    if api_request?
      raise ActionController::UnauthorizedError
    else
      redirect_to root_url
    end
  end

  def current_organ
    return @current_organ if defined?(@current_organ)
    organ_token = request.headers['Organ-Token'].presence || session[:organ_token]
    token = OrganGrant.find_by(token: organ_token)
    @current_organ = token.organ if token
  end

  def current_member
    current_user.members.find_by(organ_id: current_organ.id)
  end

  def other_organs
    current_user.organs.where.not(id: current_organ.id)
  end

  def rails_role_user
    if current_user.admin?
      current_user
    else
      current_member
    end
  end

  def set_organ_token
    return unless @current_organ
    token = current_member.organ_token
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
    { organ_id: current_organ.id }.with_indifferent_access
  end

end
