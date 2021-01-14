module Org
  class Admin::DepartmentsController < Admin::BaseController
    before_action :set_department, only: [:show, :edit, :need, :update, :destroy]
    before_action :prepare_form, only: [:new, :create, :edit, :update]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:type, :name)

      @departments = Department.default_where(q_params).roots.includes(:children, :leader, :inferiors).order(name: :asc).page(params[:page])
    end

    def supports
      default_params.merge! params.permit(:type)
      @departments = Department.roots.default_where(default_params).includes(:children, :leader).page(params[:page])
    end

    def filter
      q_params = {}
      q_params.merge! params.permit!

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
      @members = @department.all_members.includes(:member_departments).default_where(q_params).page(params[:page])
    end

    def new
      @department = Department.new(parent_id: params[:parent_id])
    end

    def create
      @department = Department.new(department_params)

      unless @department.save
        render :new, locals: { model: @department }, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      @department.assign_attributes(department_params)

      unless @department.save
        render :edit, locals: { model: @department }, status: :unprocessable_entity
      end
    end

    def need

    end

    def destroy
      @department.destroy
    end

    private
    def set_department
      @department = Department.find(params[:id])
    end

    def prepare_form
      if current_organ
        if params[:parent_id].blank? && current_organ.parent
          @root = current_organ.parent.departments.root
        else
          @root = current_organ.departments.root
        end
      else
        Department.where(organ_id: nil).root
      end
    end

    def department_params
      q = params.fetch(:department, {}).permit(
        :name,
        :needed_number,
        :logo,
        :organ_id,
        :superior_id,
        :parent_id,
        :parent_ancestors,
        :superior_ancestors
      )
      q.merge! default_form_params
    end

  end
end
