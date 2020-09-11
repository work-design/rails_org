class MeController < ApplicationController
  include RailsOrg::Me
  before_action :require_login

end unless defined? MeController
