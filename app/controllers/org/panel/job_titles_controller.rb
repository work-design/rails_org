class Org::Panel::JobTitlesController < Org::Panel::BaseController
  before_action :set_department
  before_action :set_job_title, only: [:show, :edit, :update, :destroy]

  def index
    @job_titles = JobTitle.page(params[:page])
  end

  def new
    @job_title = @department.job_titles.build
  end

  def create
    @job_title = @department.job_titles.build(job_title_params)

    respond_to do |format|
      if @job_title.save
        format.html.phone
        format.html { redirect_to panel_department_job_titles_url(@department), notice: 'Job title was successfully created.' }
        format.js { redirect_to panel_department_job_titles_url(@department) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: panel_job_titles_url }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @job_title.assign_attributes(job_title_params)

    respond_to do |format|
      if @job_title.save
        format.html.phone
        format.html { redirect_to panel_department_job_titles_url(@department), notice: 'Job title was successfully updated.' }
        format.js { redirect_to panel_department_job_titles_url(@department) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_to panel_department_job_titles_url(@department) }
        format.json { render :show }
      end
    end
  end

  def destroy
    @job_title.destroy
    redirect_to panel_department_job_titles_url(@department), notice: 'Job title was successfully destroyed.'
  end

  private
  def set_department
    @department = Department.find params[:department_id]
  end

  def set_job_title
    @job_title = JobTitle.find(params[:id])
  end

  def job_title_params
    params.fetch(:job_title, {}).permit(
      :name,
      :grade
    )
  end

end
