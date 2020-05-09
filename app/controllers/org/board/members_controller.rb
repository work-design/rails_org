class Org::Board::MembersController < Org::Board::BaseController
  before_action :set_member, only: [:show, :edit, :update, :login_my, :login_admin]

  def index
    @members = current_user.members.enabled.includes(:organ).order(id: :asc)
  end

  def new
    @member = current_user.members.build
    @identities = current_user.available_account_identities.pluck(:identity).map { |i| [i, i] }
  end

  def create
    @member = Member.find_or_initialize_by(identity: member_params[:identity])
    @member.user = current_user
    @member.assign_attributes member_params

    unless @member.save
      render :new, locals: { model: @member }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @member.assign_attributes member_params

    unless @member.save
      render :edit, locals: { model: @member }, status: :unprocessable_entity
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
  def set_member
    @member = current_user.members.find params[:id]
  end

  def member_params
    params.fetch(:member, {}).permit(
      :name,
      :identity,
      :profession,
      :attendance_number,
      :next_on_time,
      :next_off_time,
      :experience,
      :avatar
    )
  end

end
