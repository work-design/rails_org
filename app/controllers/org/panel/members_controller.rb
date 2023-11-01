module Org
  class Panel::MembersController < Panel::BaseController
    before_action :set_organ
    before_action :set_member, only: [:show, :edit, :update, :destroy, :actions, :mock]
    before_action :set_new_member, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :identity, 'name-like', :enabled)

      @members = @organ.members.includes(:roles).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def mock
      url = url_for controller: '/admin/home', host: @organ.admin_host, auth_token: @member.auth_token
      render locals: { url: url }
    end

    private
    def set_organ
      @organ = Organ.find params[:organ_id]
    end

    def set_member
      @member = @organ.members.find(params[:id])
    end

    def set_new_member
      @member = @organ.members.build member_params
    end

    def member_params
      params.fetch(:member, {}).permit(
        :name,
        :identity,
        :join_on,
        :enabled,
        :wechat_openid,
        :corp_userid,
        :avatar,
        role_ids: [],
        member_departments_attributes: {},
      )
    end

  end
end
