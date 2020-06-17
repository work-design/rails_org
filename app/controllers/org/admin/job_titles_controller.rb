class Org::Admin::JobTitlesController < Org::Admin::BaseController
  before_action :set_department
  before_action :set_job_title, only: [:show, :edit, :update, :move_higher, :move_lower, :reorder, :destroy]

  def index
    q_params = {
      department_root_id: @department.root.id
    }
    q_params.merge! default_params
    q_params.merge! params.permit(:name)

    @job_titles = JobTitle.default_where(q_params)
    @selected_job_title_ids = JobTitle.where.not(super_job_title_id: nil).where(department_root_id: @department.root.id).pluck(:super_job_title_id)
    @super_job_titles = SuperJobTitle.default_where(default_params).where.not(id: @selected_job_title_ids)
  end

  def new
    @job_title = @department.job_titles.build
  end

  def create
    @job_title = @department.job_titles.build(job_title_params)

    unless @job_title.save
      render :new, locals: { model: @job_title }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @job_title.assign_attributes(job_title_params)

    unless @job_title.save
      render :edit, locals: { model: @job_title }, status: :unprocessable_entity
    end
  end

  def create_department
    @super_job_title = SuperJobTitle.find params[:super_job_title_id]
    jtr = @super_job_title.job_titles.build(department_id: params[:department_id])
    x = JobTitle.where.not(super_job_title_id: nil).where(department_root_id: @department.root.id).max(:super_grade)
    jtr.insert_at x
  end

  def move_higher
    @job_title.move_higher
    redirect_to admin_department_job_titles_url(@department)
  end

  def move_lower
    @job_title.move_lower
    redirect_to admin_department_job_titles_url(@department)
  end

  def reorder
    sort_array = params[:sort_array].select { |i| i.integer? }

    if params[:new_index] > params[:old_index]
      prev_one = @job_title.same_job_titles.find(sort_array[params[:new_index].to_i - 1])
      @job_title.insert_at prev_one.grade
    else
      next_ones = @job_title.same_job_titles.find(sort_array[(params[:new_index].to_i + 1)..params[:old_index].to_i])
      next_ones.each do |next_one|
        next_one.insert_at @job_title.grade
      end
    end
  end

  def destroy
    @job_title.destroy
  end

  private
  def set_department
    @department = Department.find params[:department_id]
  end

  def set_job_title
    @job_title = JobTitle.where(department_root_id: @department.root.id).find(params[:id])
  end

  def job_title_params
    params.fetch(:job_title, {}).permit(
      :name,
      :description,
      :grade
    )
  end

end
