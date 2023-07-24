module Org
  class Panel::MembersController < Panel::BaseController
    before_action :set_organ
    before_action :set_member, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :identity, 'name-like', :enabled)

      @members = @organ.members.includes(:roles).default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_organ
      @organ = Organ.find params[:organ_id]
    end

    def set_member
      @member = @organ.members.find(params[:id])
    end

    def member_params
      params.fetch(:member, {}).permit(
        :name,
        :identity,
        :type,
        :join_on,
        :enabled,
        :inviter,
        :avatar,
        :resume,
        role_ids: [],
        member_departments_attributes: {},
      )
    end

  end
end
