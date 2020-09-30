class Org::Me::HomeController < Org::Admin::HomeController
  include OrgController::Me

  def index
    @notifications = Notification.limit(5)
  end

end
