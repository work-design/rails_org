class Hr::Admin::JobTitlesController < Hr::Admin::BaseController
  before_action :set_job_title, only: [:show, :edit, :update, :destroy]

  def index
    @job_titles = JobTitle.page(params[:page])
  end

  def new
    @job_title = JobTitle.new
  end

  def create
    @job_title = JobTitle.new job_title_params
    if @job_title.save
      redirect_to admin_job_titles_url, notice: 'Job Title was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @job_title.update(job_title_params)
      redirect_to admin_job_titles_url, notice: 'Job Title was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @job_title.destroy
    redirect_to admin_job_titles_url, notice: 'Job Title was successfully destroyed.'
  end

  private
  def set_job_title
    @job_title = JobTitle.find(params[:id])
  end

  def job_title_params
    params.fetch(:job_title, {}).permit(:grade, :name)
  end

end
