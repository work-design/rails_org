require 'active_support/configurable'

module RailsOrg #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.default_return_path = '/my/members'
    config.super_role_code = 'organ_admin'
  end

end


