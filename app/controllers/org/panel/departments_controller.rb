class Org::Panel::DepartmentsController < Org::Panel::BaseController
  before_action :set_department, only: [:show, :edit, :need, :update, :destroy]

  def index
    q_params = default_params
    q_params.merge! params.permit(:type, :name)
    @departments = Department.roots.default_where(q_params).includes(:children, :leader).page(params[:page])
  end

  def supports
    default_params.merge! params.permit(:type)
    @departments = Department.roots.default_where(default_params).includes(:children, :leader).page(params[:page])
  end

  def my
    @department = current_user.department
    unless @department
      redirect_to panel_departments_url and return
    end
    @departments = @department.children.page(params[:page])

    render :my, layout: 'my'
  end

  def filter
    q_params.merge! params.fetch(:q, {}).permit!
    if params[:department_id].present?
      @departments = Department.where(parent_id: params[:department_id])
    else
      @departments = Department.none
    end
    @department = @departments.first
  end

  def search
    if params[:q].present?
      @departments = Department.default_where('name-like': params[:q])
    else
      @departments = Department.none
    end

    results = []
    @departments.each do |department|
      results << { name: department.name, id: department.id }
    end
    render json: { results: results }
  end

  def show
    if @department.leaf? && !@department.root?
      @department_parent = @department.parent
    else
      @department_parent = @department
    end
    @members = Member.where(department_id: @department.self_and_descendant_ids, enabled: true).page(params[:page])
  end

  def new
    @roots = current_organ.departments.roots
    @department = current_organ.departments.build
  end

  def create
    @department = Department.new(department_params)

    if @department.save
      redirect_to panel_departments_url, notice: 'Department was successfully created.'
    else
      render :new
    end
  end

  def update
    @department.assign_attributes(department_params)

    if @department.save
      redirect_to panel_departments_url, notice: 'Department was successfully updated.'
    else
      render :edit
    end
  end

  def edit
  end

  def need

  end

  def destroy
    @department.destroy
    redirect_to panel_departments_url, notice: 'Department was successfully destroyed.'
  end

  private
  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    q = params.fetch(:department, {}).permit(
      :name,
      :type,
      :title,
      :needed_number,
      :parent_id,
      :parent_ancestors
    )
    q.merge! default_params
  end

end
