class Org::Admin::MembersController < Org::Admin::BaseController
  before_action :set_member, only: [
    :show, :edit, :update, :destroy,
    :edit_user, :update_user, :sync_one
  ]
  before_action :set_profile, only: [
    :profile, :edit_profile, :update_profile
  ]
  skip_before_action :verify_authenticity_token, only: [:departments]

  def index
    q_params = {
      enabled: true
    }.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:id, :enabled, :office_id, :department_ancestors)
    #department = Department.find_by id: Member.new(q_params).department_ancestors&.values.to_a.compact.last
    #q_params.merge! department_id: department.self_and_descendant_ids if department
    @members = Member.includes(:parent, :department, :office, :roles, :profile, user: { avatar_attachment: :blob }).default_where(q_params, {allow: nil}).order(id: :desc).page(params[:page])
  end

  def leaders
    if params[:q].present?
      @members = Member.default_where('name-like': params[:q])
    elsif params[:department_ids].present?
      department_id = params[:department_ids].split(',')[-2]
      @members = Member.where(department_id: department_id)
    else
      @members = Member.none
    end

    results = []
    @members.each do |member|
      results << { name: member.name, id: member.id }
    end
    render json: { results: results }
  end

  def new
    @member = Member.new

    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to admin_members_url, notice: 'Employee was successfully created.' }
        format.js
      else
        format.html { redirect_to admin_members_url, alert: @member.errors }
        format.js
      end
    end
  end

  def show
  end

  def profile
  end

  def sync_one
    @member.sync_current_time
    redirect_back fallback_location: admin_member_url(@member)
  end

  def edit
  end

  def update
    @member.assign_attributes(member_params)
    respond_to do |format|
      if @member.save
        format.html { redirect_to admin_members_url, notice: 'Employee was successfully updated.' }
        format.js { head :no_content }
      else
        format.html { render :edit }
        format.js { head :no_content }
      end
    end
  end

  def edit_user

  end

  def update_user
    if params[:login].include?('@')
      user = User.find_by(email: params[:login])
    else
      user = User.find_by(mobile: params[:login])
    end

    respond_to do |format|
      if @member.update(user_id: user&.id)
        format.html { redirect_to admin_members_url, notice: 'Employee was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def edit_profile
  end

  def update_profile
    @profile.assign_attributes(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to profile_admin_member_url(@member), notice: 'Employee was successfully updated.' }
        format.js { head :no_content }
      else
        format.html { render :edit }
        format.js { head :no_content }
      end
    end
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to admin_members_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_member
    @member = Member.find(params[:id])
  end

  def set_user
    @member = Member.find params[:id]
    @user = @member.user || @member.create_user
  end

  def set_profile
    set_user
    @profile = @member.profile || @member.user.create_profile
  end

  def member_params
    params.fetch(:member, {}).permit(
      :name,
      :title,
      :email,
      :type,
      :band_id,
      :office_id,
      :department_id,
      :department_ancestors,
      :parent_id,
      :join_on,
      :enabled,
      :attendance_number,
      :on_time,
      :off_time,
      :intern_begin_on,
      :probation_one_on,
      :probation_two_on,
      :formal_on,
      :children_count,
      :join_status,
      badge_ids: [],
      role_ids: [],
      job_title_ids: []
    )
  end

  def profile_params
    params.fetch(:profile, {}).permit(
      :title,
      :real_name,
      :private_email,
      :gender,
      :birthday_type,
      :birthday,
      :highest_education,
      :degree,
      :major,
      :work_experience,
      :previous_months,
      :vacation_balances
    )
  end

end
