module Org
  class Me::TutorialsController < Admin::TutorialsController
    include Org::Layout::Me
    before_action :set_tutorial, only: [:show, :edit, :perform, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params
      @tutorials = current_user.tutorials.default_where(q_params).page(params[:page])
    end

    def tutorings
      q_params = params.fetch(:q, {}).permit!
      @tutorials = current_user.tutorings.default_where(q_params).page(params[:page])
    end

    def perform
    end

    private
    def set_tutorial
      @tutorial = Tutorial.find(params[:id])
    end

    def tutorial_params
      params.fetch(:tutorial, {}).permit(
        :member_id,
        :tutor_id,
        :kind,
        :state,
        :accepted_status,
        :verified,
        :intern_begin_on,
        :probation_begin_on,
        :tutor_begin_on,
        :accepted_on,
        :performance,
        :allowance
      )
    end

  end
end
