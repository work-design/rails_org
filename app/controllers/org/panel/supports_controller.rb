class Org::Panel::SupportsController < Org::Panel::BaseController
  before_action :set_support, only: [:show, :edit, :update, :destroy]
  before_action :set_from

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:office_id)
    if params[:department_id]
      @supports = @department.supports
    else
      @supports = Support.default_where(q_params, { allow: [nil] }).page(params[:page])
    end
  end

  def new
    @support = Support.new
    @support.department_id = params[:department_id]
    @support.office_id = params[:office_id]
  end

  def create
    @support = Support.new(support_params)
    @support.department_id = @support.department_ancestors&.values.to_a.compact.last

    if @support.save
      query = {}
      query.merge! department_id: @support.department_id if @support.department_id
      query.merge! office_id: @support.office_id if @support.office_id && @support.department_id.blank?

      redirect_to panel_supports_url(query), notice: 'Crm permit was successfully created.'
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

    if @support.save
      redirect_to panel_supports_url, notice: 'Crm permit was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @support.destroy
    redirect_to panel_supports_url, notice: 'Crm permit was successfully destroyed.'
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
      :kind,
      :member_id,
      :supporter_id
    )
  end

end
