module Me
  class HomeController < BaseController

    def index
      @busynesses = current_organ.landmark_rules.where(namespace_identifier: 'admin').group_by(&:busyness)
    end

  end
end
