class Admin::BaseController < ApplicationController
  include RailsRoleController
  layout 'admin'
  before_action :require_login
  before_action :require_role

  default_form_builder 'AdminBuilder' do |config|

  end

  def current_manager
    current_user&.manager
  end

  def the_role_user
    current_user&.member || current_user
  end

end
