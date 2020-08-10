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

  def current_session_organ
    return @current_session_organ if defined?(@current_session_organ)
    sd = request.subdomains
    if sd.size == 2 && sd[1] == RailsCom.config.subdomain
      id = sd[0].split('-')[1]
      @current_session_organ = Organ.find_by(id: id)
    end
  end

  def current_member
    return @current_member if defined?(@current_member)
    @current_member = current_authorized_token&.member
  end

  def other_organs
    if current_session_organ
      current_user.organs.where.not(id: current_session_organ.id)
    else
      current_user.organs
    end
  end

  # Must order after RailsAuth::Controller
  def login_by_account(account)
    super
    @current_member = account.members.find_by(organ_id: current_session_organ.id)
    if @current_member
      current_authorized_token.update member_id: @current_member.id
      logger.debug "  ==========> Login by account #{account.id} as member: #{@current_member.id}"
    end
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
