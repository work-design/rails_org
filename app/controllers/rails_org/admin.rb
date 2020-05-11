module RailsOrg::Admin
  extend ActiveSupport::Concern
  included do
    helper_method :current_session_organ
  end

  def require_session_organ
    return if current_session_organ

    raise ActionController::RoutingError, 'Not Found'
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
    if sd.size == 2 && sd[1] == RailsOrg.config.subdomain
      @current_session_organ = Organ.find_by(code: sd[0])
    end
  end

  def default_params
    { organ_id: current_session_organ.id }
  end

  def default_form_params
    { organ_id: current_session_organ.id }
  end

  def default_filter_params
    if current_organ
      { organ_id: current_organ.self_and_descendant_ids }
    else
      default_params
    end
  end

  def organ_ancestors_params
    if current_organ
      { organ_id: current_organ.self_and_ancestor_ids }
    else
      default_params
    end
  end

end
