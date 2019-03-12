class WxController < ApplicationController
  include RailsAuthWechat
  before_action :require_user_from_wechat
  default_form_builder 'WxFormBuilder' do |config|

  end

  def current_receiver
    current_user
  end

  def check_client
    request.variant = :wechat if request.user_agent =~ /MicroMessenger/
  end

end
