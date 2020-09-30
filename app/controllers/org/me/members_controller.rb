class Org::Me::MembersController < Org::Admin::MembersController
  include OrgController::Me
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    @member.assign_attributes(member_params)

    unless @member.save
      render :edit, locals: { model: @member }, status: :unprocessable_entity
    end
  end

  def destroy
    @member.destroy
  end

  private
  def set_member
    @member = current_member
  end

  def member_params
    params.fetch(:member, {}).permit(
      :name,
      :avatar
    )
  end

end
