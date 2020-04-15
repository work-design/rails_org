class Org::Our::BaseController < RailsOrg.config.our_controller.constantize
  before_action :require_organ
end
