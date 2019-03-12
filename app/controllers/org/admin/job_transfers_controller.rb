class Org::Admin::JobTransfersController < Org::Admin::BaseController
  before_action :set_job_transfer, only: [:show, :edit, :update, :trigger, :destroy]

  def index
    q_params = params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:state, :member_id)
    @job_transfers = JobTransfer.includes(:member, :to_office, :to_department, :from_office, :from_department).default_where(q_params).order(id: :desc).page(params[:page])
  end

  def my
    if current_member.leading_office
      q_params = {
        from_office_id: current_member.leading_office.id,
        #state: JobTransfer::states[:approved_sl]
      }
    elsif current_member.leading_section
      q_params = {
        member_id: current_member.leading_section_members.map(&:id),
        #state: JobTransfer::states[:init]
      }
    end
    q_params.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit('member.name')
    q_params.merge! params.permit(:member_id, :state)

    @job_transfers = JobTransfer.includes(:member, :to_office, :to_department, :from_office, :from_department).default_where(q_params).order(id: :desc).page(params[:page])

    render :my, layout: 'my'
  end

  def new
    @job_transfer = JobTransfer.new
  end

  def create
    @job_transfer = JobTransfer.new(job_transfer_params)

    if @job_transfer.save
      redirect_to admin_job_transfers_url, notice: 'Job transfer was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @job_transfer.assign_attributes(job_transfer_params)
    @job_transfer.to_department_id = @job_transfer.department_ancestors&.values.to_a.compact.last

    if @job_transfer.save
      redirect_to admin_job_transfers_url, notice: 'Job transfer was successfully updated.'
    else
      render :edit
    end
  end

  def trigger
    @job_transfer.do_trigger(state: params[:state], auditor_id: current_member.id)
    redirect_to admin_job_transfers_url(member_id: @job_transfer.member_id)
  end

  def destroy
    @job_transfer.destroy
    redirect_to admin_job_transfers_url, notice: 'Job transfer was successfully destroyed.'
  end

  private
  def set_job_transfer
    @job_transfer = JobTransfer.find(params[:id])
  end

  def job_transfer_params
    params.fetch(:job_transfer, {}).permit(
      :to_office_id,
      :to_department_id,
      :department_ancestors,
      :transfer_on,
      :reason_note,
      :state,
      :comment
      )
  end

end
