class Org::Admin::TutorialsController < Org::Admin::BaseController
  before_action :set_tutorial, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:member_id, :tutor_id)
    @tutorials = Tutorial.preload(:member, :tutor).default_where(q_params).order(id: :desc).page(params[:page])
  end

  def my
    q_params = {
      member_id: current_user.child_ids
    }.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!

    @tutorials = Tutorial.default_where(q_params).order(id: :desc).page(params[:page])

    render :my, layout: 'my'
  end

  def new
    @tutorial = Tutorial.new params.permit(:member_id, :kind)
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)

    if @tutorial.save
      redirect_to admin_tutorials_url, notice: 'Tutorial was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @tutorial.update(tutorial_params)
      redirect_to admin_tutorials_url, notice: 'Tutorial was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tutorial.destroy
    redirect_to admin_tutorials_url, notice: 'Tutorial was successfully destroyed.'
  end

  private
  def set_tutorial
    @tutorial = Tutorial.find(params[:id])
  end

  def tutorial_params
    params.fetch(:tutorial, {}).permit(
      :member_id,
      :tutor_id,
      :kind,
      :accepted_status,
      :verified,
      :start_on,
      :finish_on,
      :performance,
      :allowance
    )
  end

end
