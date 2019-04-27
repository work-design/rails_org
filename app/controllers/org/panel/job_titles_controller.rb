class Org::Panel::JobTitlesController < Org::Panel::BaseController
  before_action :set_department
  before_action :set_job_title, only: [:show, :edit, :update, :move_higher, :move_lower, :destroy]

  def index
    q_params = {
      department_root_id: @department.root.id
    }
    q_params.merge! params.permit(:name)
    @job_titles = JobTitle.default_where(q_params).order(grade: :desc).page(params[:page])
  end

  def search
    q_params = {
      department_id: @department.self_and_descendant_ids
    }
    @job_titles = JobTitle.default_where(q_params)
  end

  def new
    @job_title = @department.job_titles.build
  end

  def create
    @job_title = @department.job_titles.build(job_title_params)
    
    respond_to do |format|
      if @job_title.save
        format.html.phone
        format.html { redirect_to panel_department_job_titles_url(@department) }
        format.js { redirect_to panel_department_job_titles_url(@department) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_to panel_department_job_titles_url(@department), status: :unprocessable_entity }
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
        format.html { redirect_to panel_job_titles_url(department_id: @job_title.department_id, office_id: @job_title.office_id) }
        format.js { redirect_to panel_job_titles_url(department_id: @job_title.department_id, office_id: @job_title.office_id) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_to panel_department_job_titles_url(@job_title.department_id) }
        format.json { render :show }
      end
    end
  end

  def move_higher
    @job_title.move_higher
    redirect_to panel_department_job_titles_url(@department)
  end

  def move_lower
    @job_title.move_lower
    redirect_to panel_department_job_titles_url(@department)
  end

  def destroy
    @job_title.destroy
    redirect_to panel_department_job_titles_url(@job_title.department_id)
  end

  private
  def set_department
    if params[:department_id]
      @department = Department.find params[:department_id]
    else
      @department = JobTitle.find(params[:id]).department
    end
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
