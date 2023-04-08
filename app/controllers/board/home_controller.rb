module Board
  class HomeController < BaseController

    def index
      redirect_to controller: current_organ.redirect_controller, action: current_organ.redirect_action
    end

  end
end
