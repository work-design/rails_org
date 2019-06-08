class Org::Admin::OrgansController < Org::Admin::BaseController
  before_action :set_organ, only: [:edit, :update, :mock, :destroy]
  before_action :require_organ, except: [:all, :mock]

  def all
    @organs = Organ.roots.order(id: :desc).page(params[:page])
  end
  
  def index
    @organs = current_organ.children.page(params[:page])
  end
  
  def current
    @organ = current_organ
  end
  
  def show
  end

  def new
    @organ = Organ.new
  end
  
  def create
    @organ = Organ.new(organ_params)
  
    if @organ.save
      render 'create'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @organ.update(organ_params)
      render 'update'
    else
      render :edit
    end
  end
  
  def mock
    organ_grant = @organ.get_organ_grant(current_member || current_user)
    login_organ_as(organ_grant)
    
    redirect_to current_admin_organs_url
  end

  def destroy
    @organ.destroy
    redirect_to admin_organs_url
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
      :parent_id,
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
