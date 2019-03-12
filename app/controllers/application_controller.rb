class ApplicationController < ActionController::Base
  include RailsAuthController
  include RailsNoticeController
  include RailsCommonController

  before_action :set_locale, :set_timezone, :check_variant
  before_action do
    if current_user&.admin?
      ServerTiming::Auth.ok!
    elsif Rails.env.development?
      ServerTiming::Auth.ok!
    else
      ServerTiming::Auth.deny!
    end
  end

  default_form_builder 'ApplicationBuilder' do |config|

  end

  def the_role_user
    current_user&.member
  end

  def check_variant
    request.variant = :phone if request.user_agent =~ /iPad|iPhone|iPod|Android/
    request.variant = :phone if request.host == ''
  end

end
