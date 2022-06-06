module Board
  class HomeController < BaseController

    def index
      @accounts = current_user.accounts.includes(members: :organ)
    end

  end
end
