module Org
  class Panel::OrgansController < Panel::BaseController

    def index
      q_params = {}
      q_params.merge! params.permit(:name)

      @organs = Organ.roots.includes(:organ_domains).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def new
      @organ = Organ.new
      @organ.area = Profiled::Area.root || Profiled::Area.new
    end

    def edit
      @organ.area || @organ.build_area
    end

    private
    def organ_permit_params
      [
        :name,
        :logo,
        :official,
        :name_short,
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
