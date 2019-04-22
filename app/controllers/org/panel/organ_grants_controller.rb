class Org::Panel::OrganGrantsController < Org::Panel::BaseController
  before_action :set_organ

  def index
    @organ_grants = current_organ.organ_grants.page(params[:page])
  end

  def new
    @organ_grant = current_organ.organ_grants.build
  end

  def create
    @organ_grant = current_organ.organ_grants.build(organ_grant_params)

    if @organ_grant.save
      redirect_to panel_organ_grants_url(current_organ)
    else
      render :new
    end
  end

  def destroy
    @organ_grant = current_organ.organ_grants.find(params[:id])
    @organ_grant.destroy
    redirect_to panel_organ_grants_url(current_organ)
  end

  private
  def set_organ
    @organ = current_organ
  end

  def organ_grant_params
    params.fetch(:organ_grant).permit(:user_id, :member_id, :token)
  end

end
