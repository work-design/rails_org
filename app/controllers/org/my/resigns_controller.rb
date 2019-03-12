class Org::My::ResignsController < Org::My::BaseController
  before_action :set_resign, only: [:show, :new, :create, :edit, :update, :destroy]

  def show
  end

  def new
  end

  def create
    @resign.assign_attributes(resign_params)

    if @resign.save
      redirect_to my_resign_url, notice: 'Resign was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @resign.update(resign_params)
      redirect_to my_resign_url, notice: 'Resign was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @resign.destroy
    redirect_to my_resign_url, notice: 'Resign was successfully destroyed.'
  end

  private
  def set_resign
    @resign = current_user.resign || current_user.build_resign
  end

  def resign_params
    params.fetch(:resign, {}).permit(
      :leave_on,
      :reason_note,
      :handover_note,
      resign_reason_ids: []
    )
  end

end
