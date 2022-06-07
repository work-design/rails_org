module Org
  class Me::ResignsController < Admin::ResignsController
    include Org::Layout::Me
    before_action :set_resign, only: [:show, :new, :create, :edit, :update, :destroy]

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
