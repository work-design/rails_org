class Hr::My::TutorialsController < Hr::My::BaseController
  before_action :set_tutorial, only: [:show, :edit, :perform, :update, :destroy]

  def index
    default_params = {

    }
    q_params = params.fetch(:q, {}).permit!
    default_params.merge! q_params
    @tutorials = current_member.tutorials.default_where(default_params).page(params[:page])
  end

  def tutorings
    q_params = params.fetch(:q, {}).permit!
    @tutorials = current_member.tutorings.default_where(q_params).page(params[:page])
  end

  def new
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)

    if @tutorial.save
      redirect_to my_tutorials_url, notice: 'Tutorial was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def perform
  end

  def update
    if @tutorial.update(tutorial_params)
      redirect_to my_tutorials_url, notice: 'Tutorial was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tutorial.destroy
    redirect_to my_tutorials_url, notice: 'Tutorial was successfully destroyed.'
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
      :state,
      :accepted_status,
      :verified,
      :intern_begin_on,
      :probation_begin_on,
      :tutor_begin_on,
      :accepted_on,
      :performance,
      :allowance
    )
  end

end
