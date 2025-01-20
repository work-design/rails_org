module Org
  class Me::ResignsController < Admin::ResignsController
    include Org::Layout::Me
    before_action :set_resign, only: [:show, :new, :create, :edit, :update, :destroy]

    def index
      if current_user.leading_office
        q_params = {
          'member.office_id': current_user.leading_office.id,
          state: Resign::states[:init]
        }

        q_params.merge! params.permit!
        @resigns = Resign.default_where(q_params).order(id: :desc).page(params[:page])
      else
        @resigns = Resign.none.page(params[:page])
      end
    end

    private
    def set_resign
      @resign = current_user.resign || current_user.build_resign
    end

    def resign_params
      params.fetch(:resign, {}).permit(
        :leave_on,
        :reason_note,
        :handover_note,
        resign_reason_ids: []
      )
    end

  end
end
