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

    unless @resign_reason.save
      render :new, locals: { model: @resign_reason }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @resign_reason.assign_attributes(resign_reason_params)

    unless @resign_reason.save
      render :edit, locals: { model: @resign_reason }, status: :unprocessable_entity
    end
  end

  def destroy
    @resign_reason.destroy
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
