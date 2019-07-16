class Org::Admin::DepartmentsController < Org::Admin::BaseController
  before_action :set_department, only: [:show, :edit, :need, :update, :destroy]
  before_action :prepare_form, only: [:new, :edit]
  
  def index
    q_params = {
      'parent_id-not': nil
    }
    q_params.merge! default_params
    q_params.merge! params.permit(:type, :name)
    @departments = Department.default_where(q_params).includes(:children, :leader).order(name: :asc).page(params[:page])
  end

  def supports
    default_params.merge! params.permit(:type)
    @departments = Department.roots.default_where(default_params).includes(:children, :leader).page(params[:page])
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
    q_params = {
      enabled: true
    }
    q_params.merge! params.permit(:enabled)
    @members = @department.all_members.default_where(q_params).page(params[:page])
  end

  def new
    if current_organ.parent
      @root = current_organ.parent.departments.root
    else
      @root = current_organ.departments.build
    end
    
    @department = current_organ.departments.build
  end

  def create
    @department = Department.new(department_params)

    if @department.save
      redirect_to admin_departments_url
    else
      @root = current_organ.departments.build
      render :new
    end
  end

  def update
    @department.assign_attributes(department_params)

    if @department.save
      redirect_to admin_departments_url
    else
      render :edit
    end
  end

  def edit
    @root = current_organ.departments.root
  end

  def need

  end

  def destroy
    @department.destroy
    redirect_to admin_departments_url
  end

  private
  def set_department
    @department = Department.find(params[:id])
  end
  
  def prepare_form
  end

  def department_params
    q = params.fetch(:department, {}).permit(
      :name,
      :type,
      :title,
      :needed_number,
      :logo,
      :office_id,
      :parent_id,
      :parent_ancestors
    )
    q.merge! default_params
  end

end
