class Org::My::MembersController < Org::My::BaseController
  before_action :set_member, only: [:show, :edit, :update, :login]
  skip_after_action :set_organ_grant, only: [:logout]
  
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
  
    respond_to do |format|
      if @member.save
        format.html { redirect_to my_members_url }
        format.js { redirect_to my_members_url }
      else
        format.html { redirect_to my_members_url, alert: @member.errors }
        format.js { render :new }
      end
    end
  end

  def show
    respond_to do |format|
      format.js
      format.html
      format.json
    end
  end

  def cert
    disposition = params[:disposition] || 'inline'
    @pdf ||= CertificationPdf.new(params[:member_badge_id])
    respond_to do |format|
      format.html
      format.js
      format.pdf { send_data @pdf.render, filename: 'cert_file', disposition: disposition, type: 'application/pdf' }
    end
  end

  def edit
  end

  def update
    @member.assign_attributes member_params
    respond_to do |format|
      if @member.save
        format.html { redirect_to my_members_url }
        format.json { render :show }
      else
        format.html { render action: 'edit' }
        format.json { render :show }
      end
    end
  end

  def login
    organ_grant = @member.get_organ_grant
    login_organ_as organ_grant

    respond_to do |format|
      format.html { redirect_to panel_organ_url }
      format.json { render json: { organ_grant: organ_grant } }
    end
  end
  
  def logout
    session.delete :organ_grant

    redirect_to my_members_url
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
