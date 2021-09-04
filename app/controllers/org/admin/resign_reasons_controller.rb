module Org
  class Admin::ResignReasonsController < Admin::BaseController

    def index
      @resign_reasons = ResignReason.where(parent_id: nil).page(params[:page])
    end

    private
    def resign_reason_permit_params
      [
        :name,
        :parent_id,
        :parent_ancestors,
        :position
      ]
    end

  end
end
