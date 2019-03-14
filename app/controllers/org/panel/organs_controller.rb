class Org::Panel::OrgansController < Org::Panel::BaseController
  before_action :set_organ, only: [:show, :edit, :update, :mock, :destroy]

  def show
  end

  def edit
  end

  def update
    if @organ.update(organ_params)
      redirect_to admin_organs_url, notice: 'Organ was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @organ.destroy
    redirect_to admin_organs_url, notice: 'Organ was successfully destroyed.'
  end


  private
  def set_organ
    @organ = current_organ
  end

  def organ_params
    params.fetch(:organ, {}).permit(
      :name,
      :organ_uuid,
      :logo
    )
  end

end
