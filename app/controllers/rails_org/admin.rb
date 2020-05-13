module RailsOrg::Admin
  extend ActiveSupport::Concern
  included do
    helper_method :current_session_organ
  end

  def require_session_organ
    return if current_session_organ

    raise ActionController::RoutingError, 'Not Found'
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
