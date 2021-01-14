module Org
  class Admin::SupportsController < Admin::BaseController
    before_action :set_support, only: [:show, :edit, :update, :destroy]
    before_action :set_from

    def index
      q_params = {
        allow: {
          organ_id: nil,
          department_id: nil
        }
      }
      q_params.merge! params.permit(:office_id)

      if params[:department_id]
        @supports = @department.supports
      else
        @supports = Support.default_where(q_params).page(params[:page])
      end
    end

    def new
      @support = Support.new(support_params)
    end

    def create
      @support = Support.new(support_params)
      @support.department_id = @support.department_ancestors&.values.to_a.compact.last

      if @support.save
        query = {}
        query.merge! department_id: @support.department_id if @support.department_id
        query.merge! office_id: @support.office_id if @support.office_id && @support.department_id.blank?

        redirect_to admin_supports_url(query)
      else
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      @support.update(support_params)
      @support.department_id = @support.department_ancestors&.values.to_a.compact.last

      unless @support.save
        render :edit, locals: { model: @support }, status: :unprocessable_entity
      end
    end

    def destroy
      @support.destroy
    end

    private
    def set_from
      if params[:department_id]
        @department = Department.find params[:department_id]
        if @department.leaf? && !@department.root?
          @department_parent = @department.parent
        else
          @department_parent = @department
        end
      end
      if params[:office_id]
        @office = Office.find params[:office_id]
      end
    end

    def set_support
      @support = Support.find(params[:id])
      @department = @support.department
    end

    def support_params
      params.fetch(:support, {}).permit(
        :department_id,
        :department_ancestors,
        :office_id,
        :name,
        :code,
        :grade,
        :member_id
      )
    end

  end
end
