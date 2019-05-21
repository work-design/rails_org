class Org::Admin::JobTitlesController < Org::Admin::BaseController
  before_action :set_department
  before_action :set_job_title, only: [:show, :edit, :update, :move_higher, :move_lower, :destroy]

  def index
    q_params = { department_root_id: nil }
    q_params.merge! default_params
    q_params.merge! department_root_id: [@department.root&.id, nil] if @department
    q_params.merge! params.permit(:name)
    @job_titles = JobTitle.default_where(q_params, department_root_id: { allow: nil }).page(params[:page])
  end

  def new
    p = { department_id: params[:department_id] }.merge! default_params
    @job_title = JobTitle.new(p)
  end

  def create
    @job_title = JobTitle.new(job_title_params)
    
    respond_to do |format|
      if @job_title.save
        format.html.phone
        format.html { redirect_to admin_job_titles_url(department_id: @department) }
        format.js { redirect_to admin_job_titles_url(department_id: @department) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_to admin_job_titles_url(department_id: @job_title.department_id), status: :unprocessable_entity }
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
        format.html { redirect_to admin_job_titles_url(department_id: @job_title.department_id) }
        format.js { redirect_to admin_job_titles_url(department_id: @job_title.department_id) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_to admin_job_titles_url(department_id: @job_title.department_id) }
        format.json { render :show }
      end
    end
  end

  def move_higher
    @job_title.move_higher
    redirect_to admin_job_titles_url(department_id: @job_title.department_id)
  end

  def move_lower
    @job_title.move_lower
    redirect_to admin_job_titles_url(department_id: @job_title.department_id)
  end

  def destroy
    @job_title.destroy
    redirect_to admin_job_titles_url(department_id: @job_title.department_id)
  end

  private
  def set_department
    if params[:department_id]
      @department = Department.find params[:department_id]
    elsif params[:id]
      @department = JobTitle.find(params[:id]).department
    end
  end

  def set_job_title
    @job_title = JobTitle.where(department_root_id: @department&.root&.id).find(params[:id])
  end

  def job_title_params
    p = params.fetch(:job_title, {}).permit(
      :name,
      :description,
      :grade,
      :department_id
    )
    p.merge! default_params
  end

end
