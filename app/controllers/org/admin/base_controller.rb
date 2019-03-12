class Org::Admin::BaseController < ApplicationController
  include RailsRoleController
  before_action :require_login
  before_action :require_role
  helper_method :current_member
  default_form_builder 'HrBuilder' do |config|

  end

  def current_member
    current_user&.member
  end

  def current_receiver
    current_member
  end

  def the_role_user
    current_member
  end

end
