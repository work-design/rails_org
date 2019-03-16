class Org::Admin::OrgansController < Org::Admin::BaseController
  before_action :set_organ, only: [:show, :edit, :update, :mock, :destroy]

  def index
    @organs = Organ.page(params[:page])
  end

  def new
    @organ = Organ.new
  end

  def create
    @organ = Organ.new(organ_params)

    respond_to do |format|
      if @organ.save
        format.html.phone
        format.html { redirect_to admin_organs_url, notice: 'Organ was successfully created.' }
        format.js { redirect_back fallback_location: admin_organs_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js
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
      redirect_to admin_organs_url, notice: 'Organ was successfully updated.'
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
    redirect_to admin_organs_url, notice: 'Organ was successfully destroyed.'
  end

  private
  def set_organ
    @organ = Organ.find(params[:id])
  end

  def organ_params
    params.fetch(:organ, {}).permit(
      :name,
      :organ_uuid,
      :logo
    )
  end

end
