class Org::Admin::OrgansController < Org::Admin::BaseController
  before_action :set_organ, only: [:edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    current_organ.assign_attributes(organ_params)

    if current_organ.save
      render 'update'
    else
      render :edit
    end
  end

  def destroy
    @organ.destroy
  end

  private
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
