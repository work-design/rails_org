class Org::Panel::OrganHandlesController < Org::Panel::BaseController
  before_action :set_organ_handle, only: [:show]

  def index
    @organ_handles = OrganHandle.order(id: :asc).page(params[:page])
  end

  def show
  end

  private
  def set_organ_handle
    @organ_handle = OrganHandle.find(params[:id])
  end

  
end
