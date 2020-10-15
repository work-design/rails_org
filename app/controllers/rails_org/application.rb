module RailsOrg::Application
  extend ActiveSupport::Concern

  included do
    helper_method :current_organ, :other_organs
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

    if request.subdomain.start_with? /org-|app-/
      @current_organ = current_domain_organ
    else
      @current_organ = current_official_organ
    end
    logger.debug "  ==========> Login as organ: #{@current_organ&.name}"
    @current_organ
  end

  def current_official_organ
    Organ.find_by domain: request.host_with_port
  end

  def current_domain_organ
    id = request.subdomains[0].to_s.split('-')[1]
    Organ.find_by(id: id)
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
