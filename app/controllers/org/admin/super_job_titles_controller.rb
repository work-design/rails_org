class Org::Admin::SuperJobTitlesController < Org::Admin::BaseController
  before_action :set_super_job_title, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    @super_job_titles = SuperJobTitle.default_where(default_params).order(grade: :asc).page(params[:page])
  end

  def new
    @super_job_title = SuperJobTitle.new
  end

  def create
    @super_job_title = SuperJobTitle.new(super_job_title_params)

    respond_to do |format|
      if @super_job_title.save
        format.html.phone
        format.html { redirect_to admin_super_job_titles_url }
        format.js { redirect_back fallback_location: admin_super_job_titles_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_super_job_titles_url }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @super_job_title.assign_attributes(super_job_title_params)

    respond_to do |format|
      if @super_job_title.save
        format.html.phone
        format.html { redirect_to admin_super_job_titles_url }
        format.js { redirect_back fallback_location: admin_super_job_titles_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_super_job_titles_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @super_job_title.destroy
    redirect_to admin_super_job_titles_url
  end

  private
  def set_super_job_title
    @super_job_title = SuperJobTitle.find(params[:id])
  end

  def super_job_title_params
    p = params.fetch(:super_job_title, {}).permit(
      :name,
      :description
    )
    p.merge! default_params
  end

end
