module Board
  class HomeController < BaseController
    before_action :require_login, only: [:direct]

    def index
    end

    def direct
      organ = current_account.organs[0]
      if organ
        render 'direct', locals: { url: url_for(controller: 'factory/buy/home', host: organ.host) }
      else
        render 'direct', locals: { url: root_url }
      end
    end

  end
end
