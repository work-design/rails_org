module Org
  class Panel::OrgansController < Panel::BaseController
    before_action :set_organ, only: [:edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:name)

      @organs = Organ.roots.includes(:organ_domains).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def show
    end

    def new
      @organ = Organ.new
      @organ.area = Area.root || Area.new
    end

    def create
      @organ = Organ.new(organ_params)

      unless @organ.save
        render :new, locals: { model: @organ }, status: :unprocessable_entity
      end
    end

    def edit
      @organ.area = @organ.area || Area.root || Area.new
    end

    def update
      @organ.assign_attributes(organ_params)

      unless @organ.save
        render :edit, locals: { model: @organ }, status: :unprocessable_entity
      end
    end

    def destroy
      @organ.destroy
    end

    private
    def set_organ
      @organ = Organ.find params[:id]
    end

    def organ_params
      params.fetch(:organ, {}).permit(
        :name,
        :logo,
        :official,
        :name_short,
        :parent_ancestors,
        :area_ancestors
      )
    end

    def organ_limit_params
      params.fetch(:organ, {}).permit(
        :limit_office,
        :limit_wechat
      )
    end

  end
end
