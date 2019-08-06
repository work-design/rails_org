class Org::Admin::SuperJobTitlesController < Org::Admin::BaseController
  before_action :set_super_job_title, only: [:show, :edit, :update, :reorder, :create_department, :destroy_department, :destroy]

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

  def reorder
    sort_array = params[:sort_array].select { |i| i.integer? }
  
    if params[:new_index] > params[:old_index]
      prev_one = @super_job_title.same_job_titles.find(sort_array[params[:new_index].to_i - 1])
      @super_job_title.insert_at prev_one.position
    else
      next_ones = @super_job_title.same_job_titles.find(sort_array[(params[:new_index].to_i + 1)..params[:old_index].to_i])
      next_ones.each do |next_one|
        next_one.insert_at @super_job_title.position
      end
    end
  end
  
  def create_department
    jtr = @super_job_title.job_title_references.build(department_id: params[:department_id])
    jtr.save
  end
  
  def destroy_department
    jtr = @super_job_title.job_title_references.where(department_id: params[:department_id])
    jtr.delete_all
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
