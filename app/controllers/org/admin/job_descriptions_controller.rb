class Org::Admin::JobDescriptionsController < Org::Admin::BaseController
  before_action :set_department
  before_action :set_job_description, only: [:show, :edit, :update, :destroy]

  def index
    @job_descriptions = @department.job_descriptions
  end

  def show
  end

  def new
    @job_description = @department.job_descriptions.build
  end

  def edit
  end

  def create
    @job_description = @department.job_descriptions.build(job_description_params)

    if @job_description.save
      redirect_to admin_department_job_descriptions_url(@department), notice: 'Job description was successfully created.'
    else
      render :new
    end
  end

  def update
    if @job_description.update(job_description_params)
      redirect_to admin_department_job_descriptions_url(@department), notice: 'Job description was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @job_description.destroy
    redirect_to admin_department_job_descriptions_url(@department), notice: 'Job description was successfully destroyed.'
  end

  private
  def set_department
    @department = Department.find params[:department_id]
    if @department.leaf? && !@department.root?
      @department_parent = @department.parent
    else
      @department_parent = @department
    end
  end

  def set_job_description
    @job_description = JobDescription.find(params[:id])
  end

  def job_description_params
    params.fetch(:job_description, {}).permit(:salary_min,
                                              :salary_max,
                                              :duties,
                                              :requirements,
                                              :advanced_requirements,
                                              :engine_requirement,
                                              :degree_requirement
    )
  end

end
