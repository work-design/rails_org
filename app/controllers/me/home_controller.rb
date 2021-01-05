class Me::HomeController < Me::BaseController

  def index
    @busynesses = Busyness.where(identifier: current_organ.role_hash.keys)
  end

end
