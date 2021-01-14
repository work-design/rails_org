module Org
  class Me::HomeController < Admin::HomeController
    include Org::Layout::Me

    def index
      @notifications = Notification.none
    end

  end
end
