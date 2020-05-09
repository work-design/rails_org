class Org::Our::HomeController < Org::Our::BaseController
  before_action :set_organ, only: [:edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    @organ.assign_attributes(organ_params)

    if @organ.save
      render 'update'
    else
      render :edit
    end
  end

  def destroy
    @organ.destroy
  end

  private
  def set_organ
    @organ = current_organ
  end

  def organ_params
    params.fetch(:organ, {}).permit(
      :name,
      :logo,
      :name_short,
      :parent_ancestors,
      :area_ancestors
    )
  end

  def organ_limit_params
    params.fetch(:organ, {}).permit(
      :limit_office,
      :limit_wechat
    )
  end

end
