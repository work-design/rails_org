class Org::My::BaseController < ApplicationController
  before_action :require_login
  helper_method :current_member, :current_teacher
  default_form_builder 'MyFormBuilder' do |config|

  end

  def the_role_user
    current_member || current_user
  end

  def current_member
    current_user&.member
  end

  def current_buyer
    current_user&.member
  end

  def current_teacher
    current_member&.teacher
  end

  def current_receiver
    current_member
  end

end
