class Org::My::DepartmentsController < Org::My::BaseController

  def index
    @departments = current_member.departments
    @members = current_member.all_followers.page(params[:page])
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
      redirect_to admin_departments_url
    else
      render :new
    end
  end


  private
  def set_department
    @department = Department.find(params[:id])
  end


end
