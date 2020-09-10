module RailsOrg::Application
  extend ActiveSupport::Concern

  included do
    helper_method :current_organ, :current_member, :other_organs
  end

  def current_title
    if current_organ
      current_organ.name
    else
      t('.title', default: :site_name)
    end
  end

  def current_organ
    return @current_organ if defined?(@current_organ)
    sd = request.subdomains
    if sd.present? && sd[1] == RailsCom.config.subdomain
      id = sd[0].split('-')[1]
      @current_organ = Organ.find_by(id: id)
    else
      current_member&.organ
    end
  end

  def current_member
    return @current_member if defined?(@current_member)
    @current_member = current_authorized_token&.member || current_account.members.find_by(organ_id: current_organ&.id)
    logger.debug "  ==========> Login as member: #{@current_member&.id}"
    @current_member
  end

  # Must order after RailsRole::Controller
  def rails_role_user
    if current_organ && current_member
      current_member
    else
      current_user
    end
  end

  def other_organs
    if current_organ
      current_user.organs.where.not(id: current_organ.id)
    else
      current_user.organs
    end
  end

  def default_params
    if current_organ
      { organ_id: current_organ.id }
    else
      super
    end
  end

  def default_form_params
    if current_organ
      { organ_id: current_organ.id }
    else
      super
    end
  end

end
