class Org::Admin::OrgansController < Org::Admin::BaseController
  before_action :set_organ, only: [:edit, :update, :mock, :destroy]
  
  def index
    q_params = {}
    q_params.merge! parent_id: current_organ&.id, allow: { parent_id: nil}

    @organs = Organ.default_where(q_params).order(id: :desc).page(params[:page])
  end
  
  def show
  end

  def new
    @organ = Organ.new
  end
  
  def create
    if organ_params.select(&->(k, v){ k.start_with?('parent_ancestors') && v.present? }).values.blank?
      @organ = Organ.new organ_params.merge!(parent_id: current_organ&.id)
    else
      @organ = Organ.new(organ_params)
    end

    unless @organ.save
      render :new, locals: { model: @organ }, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @organ.assign_attributes(organ_params)

    unless @organ.save
      render :edit, locals: { model: @organ }, status: :unprocessable_entity
    end
  end
  
  def mock
    organ_grant = @organ.get_organ_grant(current_member || current_user)
    login_organ_as(organ_grant)
    
    redirect_to panel_organ_url
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
