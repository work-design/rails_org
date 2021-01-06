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

  def current_member
    return @current_member if defined?(@current_member)

    if current_authorized_token
      @current_member = current_authorized_token.members.find_by(organ_id: current_organ&.id)
    end
    logger.debug "  ==========> Login as member: #{@current_member&.id}"
    @current_member
  end

  def current_organ
    return @current_organ if defined?(@current_organ)

    @current_organ = Organ.find_by(domain: request.host_with_port)
    logger.debug "  ==========> Login as organ: #{@current_organ&.name}"
    @current_organ
  end

  def current_organ_domain
    return @current_organ_domain if defined?(@current_organ_domain)

    @current_organ_domain = OrganDomain.find_by(identifier: request.host_with_port)
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

  def default_filter_params
    if current_organ
      { organ_id: current_organ.self_and_descendant_ids }
    else
      default_params
    end
  end

  def default_ancestors_params
    if current_organ
      { organ_id: current_organ.self_and_ancestor_ids }
    else
      default_params
    end
  end

end
