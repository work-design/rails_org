class Org::My::HomeController < Org::My::BaseController

  def index
    if current_receiver
      @notifications = current_receiver.notifications.order(read_at: :asc)
    else
      @notifications = Notification.none
    end
  end


end
