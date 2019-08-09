class PanelController < ApplicationController
  include RailsOrg::Controller
  layout 'admin'
  before_action :require_login
  after_action :set_flash, only: [:update, :create, :destroy]
  
end unless defined? PanelController
