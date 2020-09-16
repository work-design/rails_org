class Org::Me::HomeController < Org::Me::BaseController

  def index
    @notifications = Notification.limit(5)
  end

end
