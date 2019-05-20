class Org::Panel::OrgansController < Org::Panel::BaseController
  before_action :set_organ, only: [:show, :edit, :update, :destroy]
  
  def index
    @organs = current_organ.children.page(params[:page])
  end
  
  def show
  end

  def new
    @organ = current_organ.children.build
    @root = current_organ.children.build
  end
  
  def create
    @organ = current_organ.children.build(organ_params)
  
    if @organ.save
      redirect_to panel_organs_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @organ.update(organ_params)
      redirect_to panel_organ_url
    else
      render :edit
    end
  end

  def destroy
    @organ.destroy
    redirect_to panel_organ_url
  end

  private
  def set_organ
    @organ = current_organ
  end

  def organ_params
    params.fetch(:organ, {}).permit(
      :name,
      :organ_uuid,
      :logo,
      :parent_id,
      :parent_ancestors,
      :area_ancestors
    )
  end

end
