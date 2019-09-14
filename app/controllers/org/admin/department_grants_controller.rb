class Org::Admin::DepartmentGrantsController < Org::Admin::BaseController
  before_action :set_organ_handle
  before_action :set_department_grant, only: [:destroy]

  def index
  end
  
  def new
    @department_grant = @organ_handle.department_grants.build
  end

  def create
    @department_grant = @organ_handle.department_grants.build(department_grant_params)

    unless @department_grant.save
      render :new, locals: { model: @department_grant }, status: :unprocessable_entity
    end
  end

  def destroy
    @department_grant.destroy
  end

  private
  def set_organ_handle
    @organ_handle = OrganHandle.find_or_create_by(record_class: params[:record_class], record_column: params[:record_column])
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
    p.merge! default_form_params
  end

end
