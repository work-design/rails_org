class Me::HomeController < Me::BaseController

  def index
    @busynesses = Roled::Busyness.where(identifier: current_organ.role_hash.keys)
  end

end
