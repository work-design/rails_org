class Org::Admin::OrganGrantsController < Org::Admin::BaseController
  before_action :set_member

  def index
    q_params = {}
    q_params.merge! default_filter_params
    @organ_grants = @member.organ_grants.default_where(q_params).page(params[:page])
  end

  def new
    @organ_grant = @member.organ_grants.build
  end

  def create
    @organ_grant = @member.organ_grants.build(organ_grant_params)

    unless @organ_grant.save
      render :new, locals: { model: @organ_grant }, status: :unprocessable_entity
    end
  end

  def destroy
    @organ_grant = @member.organ_grants.find(params[:id])
    @organ_grant.destroy
  end

  private
  def set_member
    @member = Member.find params[:member_id]
    #@member = Member.default_where(default_params).find params[:member_id]
  end

  def organ_grant_params
    params.fetch(:organ_grant).permit(
      role_ids: []
    )
  end

end
