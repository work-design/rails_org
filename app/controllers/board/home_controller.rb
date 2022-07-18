module Board
  class HomeController < BaseController

    def index
      if current_user.members.present?
        @accounts = current_user.accounts.includes(members: :organ)
      else
        redirect_to controller: 'my/home'
      end
    end

  end
end
