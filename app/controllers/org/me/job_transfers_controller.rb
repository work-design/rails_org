module Org
  class Me::JobTransfersController < Admin::JobTransfersController
    include Org::Layout::Me
    before_action :set_job_transfer, only: [:show, :edit, :update, :destroy]

    def index
      @job_transfers = current_user.job_transfers.page(params[:page])
    end

    def new
      @job_transfer = current_user.job_transfers.build
    end

    def create
      @job_transfer = current_user.job_transfers.build(job_transfer_params)
      @job_transfer.to_department_id = @job_transfer.department_ancestors&.values.to_a.compact.last

      if @job_transfer.save
        redirect_to my_job_transfers_url
      else
        render :new
      end
    end

    def update
      @job_transfer.assign_attributes(job_transfer_params)
      @job_transfer.to_department_id = @job_transfer.department_ancestors&.values.to_a.compact.last

      if @job_transfer.save
        render 'update'
      else
        render :edit, locals: { model: @job_transfer }, status: :unprocessable_entity
      end
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
        :reason_note
      )
    end

  end
end
