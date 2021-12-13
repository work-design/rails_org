module Org
  class Admin::MemberDepartmentsController < Admin::BaseController
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

      unless @member_department.save
        render :new, locals: { model: @member_department }, status: :unprocessable_entity
      end
    end

    def options
      prepare_options
    end

    def member_options
      prepare_options

      render 'options'
    end

    private
    def set_member
      @member = Member.find params[:member_id]
    end

    def set_member_department
      @member_department = MemberDepartment.find(params[:id])
    end

    def prepare_options
      @member_department = @member.member_departments.build

      department = Department.find params[:department_id]
      q_params = {}
      q_params.merge! default_params
      q_params.merge! department_root_id: [department.root&.id, nil] if department

      @organs = current_organ.self_and_descendants
      @job_titles = JobTitle.where(q_params)
    end

    def member_department_params
      params.fetch(:member_department, {}).permit(
        :department_id,
        :department_ancestors,
        :organ_id,
        :job_title_id,
        :super_job_title_id
      )
    end

  end
end
