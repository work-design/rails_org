class Org::Membership::RecruitmentPlansController < Org::Membership::BaseController
  before_action :set_recruitment_plan, only: [:show, :edit, :update, :destroy, :comment, :handle, :confirm, :repropose]

  def index
    @recruitment_plans = current_user.recruitment_plans.page(params[:page])
  end


  def my
    department = current_user.leading_highest_department
    if department
      q_params = {
          'member.department_id': department.self_and_descendant_ids,

      }
      @recruitment_plans = RecruitmentPlan.default_where(q_params).order(id: :asc).page(params[:page])
    else
      @recruitment_plans = RecruitmentPlan.none
    end
  end

  def new
    @recruitment_plan = current_user.recruitment_plans.build
  end

  def create
    @recruitment_plan = current_user.recruitment_plans.build(recruitment_plan_params)
    if @recruitment_plan.save
      redirect_to my_recruitment_plans_url
    else
      render :new
    end
  end

  def comment
  end

  def show
  end

  def edit
  end

  def update
    @recruitment_plan.assign_attributes(recruitment_plan_params)

    if @recruitment_plan.save
      redirect_to my_recruitment_plans_url
    else
      render :edit
    end
  end

  def destroy
    @recruitment_plan.destroy
    redirect_to my_recruitment_plans_url
  end

  def handle
    if params[:recruitment_plan]
      q_params =  {rejected: true}
      q_params.merge! params.fetch(:recruitment_plan, {}).permit(:comment)
    else
      q_params = params.permit(:state)
    end
    @recruitment_plan.update(q_params)
    @recruitment_plan.save
    redirect_to my_my_recruitment_plans_url
  end

  def repropose
    q_params =  {rejected: false}
    @recruitment_plan.update(q_params)
    @recruitment_plan.save
    redirect_to my_my_recruitment_plans_url
  end

  def confirm
  end

  private
  def set_recruitment_plan
    @recruitment_plan = RecruitmentPlan.find(params[:id])
  end

  def recruitment_plan_params
    params.fetch(:recruitment_plan, {}).permit(:journal_id,
                                           :me_count,
                                           :ae_count)
  end

end
