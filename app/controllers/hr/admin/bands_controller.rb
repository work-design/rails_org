class Hr::Admin::BandsController < Hr::Admin::BaseController
  before_action :set_band, only: [:show, :edit, :update, :destroy]

  def index
    q_params = params.fetch(:q, {}).permit!
    @bands = Band.default_where(q_params).page(params[:page])
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to admin_bands_url, notice: 'Band was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @band.update(band_params)
      redirect_to admin_bands_url, notice: 'Band was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @band.destroy
    redirect_to admin_bands_url, notice: 'Band was successfully destroyed.'
  end

  private
  def set_band
    @band = Band.find(params[:id])
  end

  def band_params
    params.fetch(:band, {}).permit(:name, :role)
  end

end
