class Org::My::MembersController < Org::My::BaseController

  def index
    @members = current_user.members.includes(:organ, :department, :office)
  end

  def show
    respond_to do |format|
      format.js
      format.html
      format.json { render json: @member }
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
    respond_to do |format|
      if @member.update member_params
        format.html { redirect_to my_member_url, notice: 'Member was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private
  def member_params
    params.fetch(:member, {}).permit(
      :profession,
      :attendance_number,
      :next_on_time,
      :next_off_time,
      :experience,
      :parent_id
    )
  end

end
