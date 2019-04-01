class Org::Panel::MembersController < Org::Panel::BaseController
  before_action :set_member, only: [:show, :edit, :update, :token, :destroy, :sync_one]

  def index
    q_params = default_params.merge! enabled: true
    q_params.merge! params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:id, :enabled, :office_id, :department_ancestors)
    #department = Department.find_by id: Member.new(q_params).department_ancestors&.values.to_a.compact.last
    #q_params.merge! department_id: department.self_and_descendant_ids if department
    @members = Member.includes(:department, :office, :roles, user: { avatar_attachment: :blob }).default_where(q_params, {allow: nil}).order(id: :desc).page(params[:page])
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
    @member.member_departments.build

    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to panel_members_url, notice: 'Employee was successfully created.' }
        format.js
      else
        format.html { redirect_to panel_members_url, alert: @member.errors }
        format.js
      end
    end
  end

  def show
  end

  def profile
  end

  def edit
    if @member.member_departments.count == 0
      @member.member_departments.build
    end
  end

  def update
    @member.assign_attributes(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to panel_members_url, notice: 'Employee was successfully updated.' }
        format.js { redirect_to panel_members_url }
      else
        format.html { render :edit }
        format.js { redirect_to panel_members_url }
      end
    end
  end

  def add_item
    @member = Member.new
    @member.member_departments.build
  end

  def remove_item

  end

  def token
    @member.refresh_organ_token
    redirect_back fallback_location: panel_members_url
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to panel_members_url, notice: 'Employee was successfully destroyed.' }
      format.js { redirect_to panel_members_url }
      format.json { redirect_to panel_members_url }
    end
  end

  private
  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    q = params.fetch(:member, {}).permit(
      :name,
      :identity,
      :type,
      :office_id,
      :join_on,
      :enabled,
      :intern_begin_on,
      :probation_one_on,
      :probation_two_on,
      :formal_on,
      :join_status,
      role_ids: [],
      member_departments_attributes: {}
    )
    q.merge! default_params
  end

end
