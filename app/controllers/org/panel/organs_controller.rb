module Org
  class Panel::OrgansController < Panel::BaseController
    before_action :set_organ, only: [:edit]

    def index
      q_params = {}
      q_params.merge! params.permit('name-like')

      @organs = Organ.roots.includes(:organ_domains).default_where(q_params).unscope(:order).order(id: :desc).page(params[:page])
    end

    def new
      @organ = Organ.new
      @organ.area = Profiled::Area.root || Profiled::Area.new if defined? RailsProfile
    end

    def edit
      @organ.area || @organ.build_area
    end

    private
    def set_organ
      @organ = Organ.find params[:id]
    end

    def organ_permit_params
      [
        :name,
        :logo,
        :official,
        :name_short,
        :license,
        :parent_ancestors,
        :area_ancestors
      ]
    end

    def organ_limit_params
      params.fetch(:organ, {}).permit(
        :limit_office,
        :limit_wechat
      )
    end

  end
end
