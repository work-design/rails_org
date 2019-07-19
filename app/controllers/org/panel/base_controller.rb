class Org::Panel::BaseController < RailsOrg.config.panel_controller.constantize
  before_action :require_organ
end
