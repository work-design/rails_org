require 'active_support/configurable'

module RailsOrg #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_controller = 'ApplicationController'
    config.my_controller = 'MyController'
    config.admin_controller = 'AdminController'
    config.panel_controller = 'PanelController'
    config.disabled_models = []
  end

end


