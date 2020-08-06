class Org::Board::MembersController < Org::Board::BaseController
  before_action :set_member, only: [:login_my, :login_admin]

  def index
    @organs = current_user.members.includes(:organ).where.not(organ_id: nil).group_by(&:organ)
    session.delete :organ_token
    if @organs.blank?
      set_organs
      render :new
    else
      render 'index'
    end
  end

  def new
    set_organs
  end

  def near
    @organs = Organ.where(official: false).limit(5)
  end

  def create
    @member = current_user.members.build
    @member.assign_attributes member_params

    if @member.save
      render 'create', locals: { return_to: params[:return_to].presence || my_members_url }
    else
      render :new, locals: { model: @member }, status: :unprocessable_entity
    end
  end

  def login_my
    @organ_grant = @member.get_organ_grant
    login_organ_as @organ_grant
  end

  def login_admin
    @organ_grant = @member.get_organ_grant
    login_organ_as @organ_grant
  end

  private
  def set_organs
    @organs = Organ.where(official: false).limit(5)
    @member = current_user.members.build
    @organ = @member.build_organ
    @identities = current_user.available_account_identities.pluck(:identity).map { |i| [i, i] }
  end

  def set_member
    @member = current_user.members.find params[:id]
  end

  def member_params
    params.fetch(:member, {}).permit(
      :name,
      :organ_id,
      :identity,
      :profession,
      :attendance_number,
      :next_on_time,
      :next_off_time,
      :experience,
      :avatar,
      organ_attributes: {}
    )
  end

end
