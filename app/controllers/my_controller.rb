class MyController < ApplicationController
  include RailsOrg::My
  before_action :require_login

end unless defined? MyController
