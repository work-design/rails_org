class Org::Board::MembersController < Org::Board::BaseController

  def index
    @organs = current_user.members.includes(:organ).where.not(organ_id: nil).group_by(&:organ)
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
      render 'create', locals: { return_to: params[:return_to].presence || me_members_url }
    else
      render :new, locals: { model: @member }, status: :unprocessable_entity
    end
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
