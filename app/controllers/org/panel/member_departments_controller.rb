class Org::Panel::MemberDepartmentsController < Org::Panel::BaseController
  before_action :set_member
  before_action :set_member_department, only: [:show, :edit, :update, :destroy]

  def index
    @member_departments = MemberDepartment.page(params[:page])
  end

  def new
    @member_department = @member.member_departments.build
  end

  def create
    @member_department = @member.member_departments.build(member_department_params)

    respond_to do |format|
      if @member_department.save
        format.html.phone
        format.html { redirect_to panel_members_url }
        format.js { redirect_back fallback_location: panel_members_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: panel_members_url }
        format.json { render :show }
      end
    end
  end

  def options
    @member_department = @member.member_departments.build
    
    department = Department.find params[:department_id]
    @offices = department.office || current_organ.offices
    @job_titles = JobTitle.where(department_id: department.self_and_descendant_ids)
  end
  
  def member_options
    @member_department = @member.member_departments.build
  
    department = Department.find params[:department_id]
    @offices = department.office || current_organ.offices
    @job_titles = JobTitle.where(department_id: department.self_and_descendant_ids)
    
    render 'options'
  end

  def show
  end

  def edit
  end

  def update
    @member_department.assign_attributes(member_department_params)

    respond_to do |format|
      if @member_department.save
        format.html.phone
        format.html { redirect_to panel_member_departments_url }
        format.js { redirect_back fallback_location: panel_member_departments_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: panel_member_departments_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @member_department.destroy
    redirect_to panel_member_departments_url
  end

  private
  def set_member
    @member = Member.find params[:member_id]
  end
  
  def set_member_department
    @member_department = MemberDepartment.find(params[:id])
  end

  def member_department_params
    params.fetch(:member_department, {}).permit(
      :department_id,
      :department_ancestors,
      :office_id,
      :job_title_id
    )
  end

end
