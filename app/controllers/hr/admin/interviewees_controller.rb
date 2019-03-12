class Hr::Admin::IntervieweesController < Hr::Admin::BaseController
  before_action :set_model, only: [:show, :edit, :update, :destroy, :email, :search, :send_to, :add_attach, :remove_attach]
  before_action :json_data, only: [:send_to, :email]

  def index
    q_params = params.fetch(:q, {}).permit!
    @interviewees = Interviewee.default_where(q_params).order(id: :desc).page(params[:page])
  end

  def new
    @interviewee = Interviewee.new
  end

  def create
    @interviewee = Interviewee.new(valid_params)
    @interviewee.member = current_member
    if @interviewee.save
      redirect_to admin_interviewees_url, notice: 'Interviewee was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def search
    if params[:category].present?
      results = []
      @email_templates = EmailTemplate.where(category: params[:category])
      @email_templates.each do |email_template|
        results << { name: email_template.name, id: email_template.id }
      end
      render json: { status: 'success', data: results }
    else
      if params[:email_tpl_id].present?
        @email_template = EmailTemplate.find(params[:email_tpl_id])
        file = nil
        file = @email_template.file.filename if @email_template.file.attached?
        render json: { status: 'success', data: { subject: @email_template.subject, body: @email_template.body, file: file } }
      else
        render json: { status: 'error' }
      end
    end
  end

  def email
    @email_history = EmailHistory.new
  end

  def send_to
    @email_history = EmailHistory.new(valid_email_params)
    @email_history.historyable = @interviewee
    if @email_history.save
      @email_template = EmailTemplate.find(params[:email_history][:email_template]) unless params[:has_tpl].nil?
      IntervieweeMailer.send_email(@email_history, @interviewee, @email_template).deliver_now
      @interviewee.attachments.each do |file|
        file.purge_later
      end
      redirect_to admin_interviewees_url, notice: 'Email was successfully sent.'
    else
      render :email
    end
  end


  def add_attach
    @interviewee.attachments.attach(params[:email_history][:attachments])
    attach = []
    @interviewee.attachments.each do |file|
      attach << { name: file.filename, blob_id: file.blob_id, id: @interviewee.id }
    end
    render json: attach
  end

  def remove_attach
    @interviewee.attachments.each do |file|
      file.purge_later if file.blob_id == params[:blob_id].to_i
    end
    render json: {result: 'ok'}
  end

  def update
    if @interviewee.update(valid_params)
      redirect_to admin_interviewees_url, notice: 'Interviewee was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @interviewee.destroy
    redirect_to admin_interviewees_url, notice: 'Interviewee was successfully destroyed.'
  end

  private
  def set_model
    @interviewee = Interviewee.find(params[:id])
  end

  def valid_params
    params.fetch(:interviewee, {}).permit(
      :department_id,
      :office_id,
      :name,
      :chinese_name,
      :gender,
      :contact,
      :email,
      :private_email,
      :university,
      :major,
      :degree,
      :interview_time,
      :interview_status,
      :training_begin,
      :training_end,
      :join_date,
      :note,
      :position,
      :channel,
      :state
    )
  end

  def valid_email_params
    q_params = params.fetch(:email_history, {}).permit(
      :from,
      :to,
      :subject,
      :body,
      cc: []
    )
    q_params[:cc].reject! {|e| e.blank?} if q_params[:cc].length > 0
    q_params
  end

  def json_data
    @json_data = {
        name: @interviewee.name,
        gender_title: @interviewee.gender == 'male' ? 'Mr.' : 'Ms.',
        written_exam_time: @interviewee.interview_time.try(:strftime, "%H:%M on %d %B %Y"),
        training_begin: @interviewee.training_begin.try(:strftime, "%H:%M on %d %B %Y"),
        training_end: @interviewee.training_end.try(:strftime, "%H:%M on %d %B %Y"),
        join_date: @interviewee.join_date.try(:strftime, "%H:%M on %d %B %Y"),
        office: {
            address: @interviewee.office.address,
            chinese_address: @interviewee.office.address_cn,
            name: @interviewee.office.try(:name)
        },
        section: {
            name: @interviewee.department.try(:name)
        },
        city_chinese: @interviewee.office.city,
        office_contact: @interviewee.office.contact,
        zhilian: @interviewee.office.recruitment
    }.to_json
  end

end
