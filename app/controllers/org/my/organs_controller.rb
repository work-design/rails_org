class Org::My::OrgansController < Org::My::BaseController
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
        format.html { redirect_to panel_organs_url, notice: 'Organ was successfully created.' }
        format.html.phone
        format.json { render :show }
      else
        format.html { render :new }
        format.html.phone { render :new }
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
      redirect_to panel_organs_url, notice: 'Organ was successfully updated.'
    else
      render :edit
    end
  end

  def login
    token = current_member.get_organ_token

    respond_to do |format|
      format.html {
        session[:organ_token] = token
        redirect_to panel_organ_url
      }
      format.json { render json: { organ_token: token } }
    end
  end

  def destroy
    @organ.destroy
    redirect_to panel_organs_url, notice: 'Organ was successfully destroyed.'
  end

  private
  def set_organ
    @organ = Organ.find(params[:id])
  end

  def organ_params
    params.fetch(:organ, {}).permit(
      :name,
      :organ_uuid
    )
  end

end
