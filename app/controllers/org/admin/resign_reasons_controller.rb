class Org::Admin::ResignReasonsController < Org::Admin::BaseController
  before_action :set_resign_reason, only: [:show, :edit, :update, :destroy]

  def index
    @resign_reasons = ResignReason.where(parent_id: nil).page(params[:page])
  end

  def new
    @resign_reason = ResignReason.new
  end

  def create
    @resign_reason = ResignReason.new(resign_reason_params)

    if @resign_reason.save
      redirect_to admin_resign_reasons_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @resign_reason.assign_attributes(resign_reason_params)

    if @resign_reason.save
      redirect_to admin_resign_reasons_url
    else
      render :edit
    end
  end

  def destroy
    @resign_reason.destroy
    redirect_to admin_resign_reasons_url
  end

  private
  def set_resign_reason
    @resign_reason = ResignReason.find(params[:id])
  end

  def resign_reason_params
    params.fetch(:resign_reason, {}).permit(
      :name,
      :parent_id,
      :parent_ancestors,
      :position
    )
  end

end
