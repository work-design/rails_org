module Org
  class Admin::JobTransfersController < Admin::BaseController
    before_action :set_job_transfer, only: [:show, :edit, :update, :trigger, :destroy]
    before_action :set_new_job_transfer, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! params.permit(:state, :member_id)

      @job_transfers = JobTransfer.includes(:member, :to_office, :to_department, :from_office, :from_department).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def my
      if current_user.leading_office
        q_params = {
          from_office_id: current_user.leading_office.id,
          #state: JobTransfer::states[:approved_sl]
        }
      elsif current_user.leading_section
        q_params = {
          member_id: current_user.leading_section_members.map(&:id),
          #state: JobTransfer::states[:init]
        }
      else
        q_params = {}
      end
      q_params.merge! params.permit('member.name')
      q_params.merge! params.permit(:member_id, :state)

      @job_transfers = JobTransfer.includes(:member, :to_office, :to_department, :from_office, :from_department).default_where(q_params).order(id: :desc).page(params[:page])

      render :my, layout: 'my'
    end

    def update
      @job_transfer.assign_attributes(job_transfer_params)
      @job_transfer.to_department_id = @job_transfer.department_ancestors&.values.to_a.compact.last

      unless @job_transfer.save
        render :edit, locals: { model: @job_transfer }, status: :unprocessable_entity
      end
    end

    def trigger
      @job_transfer.do_trigger(state: params[:state], auditor_id: current_user.id)
      redirect_to admin_job_transfers_url(member_id: @job_transfer.member_id)
    end

    private
    def set_job_transfer
      @job_transfer = JobTransfer.find(params[:id])
    end

    def set_new_job_transfer
      @job_transfer = JobTransfer.new(job_transfer_params)
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
end
