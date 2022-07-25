module Admin
  class HomeController < BaseController

    def index
      @meta_businesses = current_organ.landmark_rules.joins(:meta_business).includes(:meta_business).where(namespace_identifier: 'admin').unscope(:order).order('com_meta_businesses.position': :asc).group_by(&:meta_business)
    end

  end
end
