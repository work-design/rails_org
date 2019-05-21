class Org::Admin::DepartmentGrantsController < Org::Admin::BaseController
  before_action :set_organ_handle
  before_action :set_department_grant, only: [:destroy]

  def index
    @organ_handles = OrganHandle.order(id: :asc).page(params[:page])
  end
  
  def new
    @department_grant = @organ_handle.department_grants.build
  end

  def create
    @department_grant = @organ_handle.department_grants.build(department_grant_params)

    respond_to do |format|
      if @department_grant.save
        format.html.phone
        format.html { redirect_to admin_department_grants_url }
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

  def destroy
    @department_grant.destroy
    redirect_to admin_organ_handles_url
  end

  private
  def set_organ_handle
    @organ_handle = OrganHandle.find params[:organ_handle_id]
  end
  
  def set_department_grant
    @department_grant = @organ_handle.department_grants.default_where(default_params).find(params[:id])
  end

  def department_grant_params
    p = params.fetch(:department_grant, {}).permit(
      :organ_handle_id,
      :department_id,
      :job_title_id
    )
    p.merge! default_params
  end

end
