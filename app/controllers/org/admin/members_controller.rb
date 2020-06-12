class Org::Admin::MembersController < Org::Admin::BaseController
  before_action :set_member, only: [:show, :edit, :update, :mock, :profile, :token, :destroy]

  def index
    q_params = {
      enabled: true
    }
    q_params.merge! default_filter_params
    q_params.merge! params.permit(:id, :identity, :organ_id, 'name-like', :enabled, :department_ancestors)
    #department = Department.find_by id: Member.new(q_params).department_ancestors&.values.to_a.compact.last
    #q_params.merge! department_id: department.self_and_descendant_ids if department
    @members = Member.includes(:organ, :roles, member_departments: [:job_title, :department]).default_where(q_params).order(id: :desc).page(params[:page])
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
    if current_organ
      @member = current_organ.members.build
    else
      @member = Member.new
    end
    @member.member_departments.build(department_id: params[:department_id])
    @member.member_supers.build
  end

  def create
    if current_organ
      @member = current_organ.members.build
    else
      @member = Member.new
    end
    @member.assign_attributes member_params

    unless @member.save
      render :new, locals: { model: @member }, status: :unprocessable_entity
    end
  end

  def options
    if current_organ
      @member = current_organ.members.build
    else
      @member = Member.new
    end
    @department = Department.find(params[:department_id]) if params[:department_id]
    @member_department = @member.member_departments.build(department_id: params[:department_id])
  end

  def show
  end

  def profile
    @profile = @member.profile || @member.create_profile
  end

  def edit
    if @member.member_departments.count == 0
      @member.member_departments.build(department_id: params[:department_id])
    end
    if @member.member_supers.count == 0
      @member.member_supers.build
    end
  end

  def update
    @member.assign_attributes(member_params)

    unless @member.save
      render :edit, locals: { model: @member }, status: :unprocessable_entity
    end
  end

  def mock
    organ_grant = @member.mock_organ_grant(current_user.id)
    login_organ_as(organ_grant)

    redirect_to panel_organ_url
  end

  def add_item
    @member = Member.new
    @member.member_departments.build
  end

  def remove_item

  end

  def token
    @member.refresh_organ_token
    redirect_back fallback_location: admin_members_url
  end

  def destroy
    @member.destroy
  end

  private
  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.fetch(:member, {}).permit(
      :name,
      :identity,
      :type,
      :join_on,
      :enabled,
      :avatar,
      :resume,
      role_ids: [],
      member_departments_attributes: {}
    )
  end

end
