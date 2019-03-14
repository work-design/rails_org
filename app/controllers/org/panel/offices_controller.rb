class Org::Panel::OfficesController < Org::Panel::BaseController
  before_action :set_office, only: [:show, :edit, :update, :destroy]

  def index
    @offices = Office.page(params[:page])
  end

  def show
  end

  def new
    @office = Office.new
  end

  def edit
  end

  def create
    @office = Office.new(office_params)

    if @office.save
      redirect_to panel_offices_url, notice: 'Office was successfully created.'
    else
      render :new
    end
  end

  def update
    if @office.update(office_params)
      redirect_to panel_offices_url, notice: 'Office was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @office.destroy
    redirect_to panel_offices_url, notice: 'Office was successfully destroyed.'
  end

  private
  def set_office
    @office = Office.find(params[:id])
  end

  def office_params
    params.fetch(:office, {}).permit(
      :name,
      :country,
      :city,
      :floor,
      :address,
      :address_cn,
      :absence_email,
      :lunch_time,
      :deputy_leader_id,
      :name_short,
      :timezone,
      :contact,
      :recruitment,
      :locale,
      :area_ancestors
    )
  end

end
