class MeController < AdminController
  include Org::Controller::Me
  before_action :require_member

end
