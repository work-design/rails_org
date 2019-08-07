require 'active_support/configurable'

module RailsOrg #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_controller = 'ApplicationController'
    config.admin_controller = 'AdminController'
    config.panel_controller = 'PanelController'
    config.my_controller = 'MyController'
    config.member_controller = 'MemberController'
    config.org_controller = 'OrgController'
    config.default_return_path = '/my/members'
    config.super_role_code = 'organ_admin'
  end

end


