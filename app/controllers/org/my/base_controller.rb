class Org::My::BaseController < ApplicationController
  before_action :require_login
  helper_method :current_user, :current_teacher
  default_form_builder 'MyFormBuilder' do |config|

  end

  def the_role_user
    current_user || current_user
  end

  def current_user
    current_user&.member
  end

  def current_buyer
    current_user&.member
  end

  def current_teacher
    current_user&.teacher
  end

  def current_receiver
    current_user
  end

end
