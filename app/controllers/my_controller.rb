class MyController < ApplicationController
  before_action :require_login

  default_form_builder 'MyFormBuilder' do |config|

  end



end
