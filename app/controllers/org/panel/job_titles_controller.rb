class Org::Panel::JobTitlesController < Org::Panel::BaseController
  before_action :set_from
  before_action :set_job_title, only: [:show, :edit, :update, :move_higher, :move_lower, :destroy]

  def index
    q_params = {
      department_id: params[:department_id]
    }.with_indifferent_access
    q_params.merge! params.permit(:office_id)
    @job_titles = JobTitle.default_where(q_params).order(grade: :desc).page(params[:page])
  end

  def search
    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:department_id, :office_id)
    @job_titles = JobTitle.default_where(q_params).page(params[:page])

    render json: { results: @job_titles.as_json(only: [:name, :id]) }
  end

  def new
    @job_title = JobTitle.new(params.permit(:department_id, :office_id))
  end

  def create
    @job_title = JobTitle.new(job_title_params)

    respond_to do |format|
      if @job_title.save
        format.html.phone
        format.html { redirect_to panel_job_titles_url(department_id: @job_title.department_id, office_id: @job_title.office_id), notice: 'Job title was successfully created.' }
        format.js { redirect_to panel_job_titles_url(department_id: @job_title.department_id, office_id: @job_title.office_id) }
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
        format.html { redirect_to panel_job_titles_url(department_id: @job_title.department_id, office_id: @job_title.office_id), notice: 'Job title was successfully updated.' }
        format.js { redirect_to panel_job_titles_url(department_id: @job_title.department_id, office_id: @job_title.office_id) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_to panel_job_titles_url(department_id: @job_title.department_id, office_id: @job_title.office_id) }
        format.json { render :show }
      end
    end
  end

  def move_higher
    @job_title.move_higher
    redirect_to panel_job_titles_url(request.query_parameters)
  end

  def move_lower
    @job_title.move_lower
    redirect_to panel_job_titles_url(request.query_parameters)
  end

  def destroy
    @job_title.destroy
    redirect_to panel_job_titles_url(department_id: @job_title.department_id, office_id: @job_title.office_id), notice: 'Job title was successfully destroyed.'
  end

  private
  def set_from
    if params[:department_id]
      @department = Department.find params[:department_id]
      if @department.leaf? && !@department.root?
        @department_parent = @department.parent
      else
        @department_parent = @department
      end
    end
    if params[:office_id]
      @office = Office.find params[:office_id]
    end
  end

  def set_job_title
    @job_title = JobTitle.find(params[:id])
  end

  def job_title_params
    params.fetch(:job_title, {}).permit(
      :name,
      :grade,
      :department_id,
      :office_id
    )
  end

end
