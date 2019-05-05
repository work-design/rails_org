class Org::Admin::OrgansController < Org::Admin::BaseController
  before_action :set_organ, only: [:show, :edit, :update, :mock, :destroy]

  def index
    @organs = Organ.order(id: :desc).page(params[:page])
  end

  def new
    @organ = Organ.new
  end

  def create
    @organ = Organ.new(organ_params)

    respond_to do |format|
      if @organ.save
        format.html.phone
        format.html { redirect_to admin_organs_url }
        format.js { redirect_back fallback_location: admin_organs_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { render :new }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @organ.update(organ_params)
      redirect_to admin_organs_url
    else
      render :edit
    end
  end

  def mock
    session[:organ_token] = @organ.get_organ_token(current_user.id)
    redirect_to panel_organ_url
  end

  def destroy
    @organ.destroy
    redirect_to admin_organs_url
  end

  private
  def set_organ
    @organ = Organ.find(params[:id])
  end

  def organ_params
    params.fetch(:organ, {}).permit(
      :name,
      :organ_uuid,
      :limit_office,
      :limit_wechat,
      :logo
    )
  end

end
