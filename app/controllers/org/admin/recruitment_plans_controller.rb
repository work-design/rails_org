class Hr::Admin::RecruitmentPlansController < Hr::Admin::BaseController
  before_action :set_recruitment_plan, only: [:show, :edit, :update, :destroy]

  def index
    q_params = params.fetch(:q, {}).permit(:state)
    q_params.merge! params.permit(:state)
    @recruitment_plans = RecruitmentPlan.default_where(q_params).order(id: :desc).page(params[:page])
  end

  # def new
  #   @recruitment_plans = RecruitmentPlan.new
  # end
  #
  # def create
  #   @recruitment_plans = RecruitmentPlan.new(recruitment_plans_param)
  #
  #   if @recruitment_plans.save
  #     redirect_to admin_recruitment_planss_url, notice: 'Job transfer was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  def show
  end

  def edit
  end

  def update
    @recruitment_plan.assign_attributes(recruitment_plan_params)

    if @recruitment_plan.save
      redirect_to admin_recruitment_plans_url, notice: 'Recruitment plan was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recruitment_plan.destroy
    redirect_to admin_recruitment_plans_url, notice: 'Recruitment plan was successfully destroyed.'
  end

  private
  def set_recruitment_plan
    @recruitment_plan = RecruitmentPlan.find(params[:id])
  end

  def recruitment_plan_params
    params.fetch(:recruitment_plan, {}).permit(
      :journal_id,
      :ae_count,
      :me_count,
      :state,
      :comment,
      :rejected
      )
  end

end
