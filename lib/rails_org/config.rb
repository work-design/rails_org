require 'active_support/configurable'

module RailsOrg #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_controller = 'ApplicationController'
    config.admin_controller = 'AdminController'
    config.panel_controller = 'PanelController'
    config.our_controller = 'OurController'
    config.my_controller = 'MyController'
    config.board_controller = 'BoardController'
    config.default_return_path = '/my/members'
    config.super_role_code = 'organ_admin'
    config.subdomain = 't'
  end

end


