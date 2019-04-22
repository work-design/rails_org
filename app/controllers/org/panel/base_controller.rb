class Org::Panel::BaseController < RailsOrg.config.panel_controller.constantize

  after_action :set_flash, only: [:update, :create]

end
