module Me
  class HomeController < BaseController

    def index
      @busynesses = current_organ.landmark_rules.joins(:busyness).includes(:busyness).where(namespace_identifier: 'admin').unscope(:order).order('busynesses.position': :asc).group_by(&:busyness)
    end

  end
end
