class Org::Admin::OrganHandlesController < Org::Admin::BaseController
  before_action :set_organ_handle, only: [:show, :edit, :update, :destroy]

  def index
    @organ_handles = OrganHandle.order(id: :asc).page(params[:page])
  end

  def new
    @organ_handle = OrganHandle.new
  end

  def create
    @organ_handle = OrganHandle.new(organ_handle_params)

    respond_to do |format|
      if @organ_handle.save
        format.html.phone
        format.html { redirect_to admin_organ_handles_url }
        format.js { redirect_back fallback_location: admin_organ_handles_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_organ_handles_url }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @organ_handle.assign_attributes(organ_handle_params)

    respond_to do |format|
      if @organ_handle.save
        format.html.phone
        format.html { redirect_to admin_organ_handles_url }
        format.js { redirect_back fallback_location: admin_organ_handles_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_organ_handles_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @organ_handle.destroy
    redirect_to admin_organ_handles_url
  end

  private
  def set_organ_handle
    @organ_handle = OrganHandle.find(params[:id])
  end

  def organ_handle_params
    params.fetch(:organ_handle, {}).permit(
      :name,
      :description,
      :record_class,
      :record_column
    )
  end

end
