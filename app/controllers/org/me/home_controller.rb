class Org::Me::HomeController < Org::Admin::HomeController
  include OrgController::Me

  def index
    @notifications = Notification.none
  end

end
