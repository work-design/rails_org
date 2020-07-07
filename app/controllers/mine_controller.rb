class MineController < BoardController
  include RailsOrg::Application
  before_action :require_member

end unless defined? MineController
