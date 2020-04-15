require 'active_support/configurable'

module RailsOrg #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_controller = 'ApplicationController'
    config.admin_controller = 'AdminController'
    config.our_controller = 'OurController'
    config.my_controller = 'MyController'
    config.mine_controller = 'MineController'
    config.membership_controller = 'MembershipController'
    config.default_return_path = '/my/members'
    config.super_role_code = 'organ_admin'
    config.subdomain = 't'
  end

end


