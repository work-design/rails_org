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
    if request.subdomains.present? && request.subdomains[1] == RailsCom.config.subdomain.presence
      current_domain_organ
    else
      current_member&.organ
    end
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

  def current_domain_organ
    return @current_domain_organ if defined? @current_domain_organ
    id = request.subdomains[0].to_s.split('-')[1]
    if id
      @current_domain_organ = Organ.find_by(id: id)
    else
      @current_domain_organ = nil
    end
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
