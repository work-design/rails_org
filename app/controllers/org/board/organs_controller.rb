module Org
  class Board::OrgansController < Board::BaseController
    before_action :set_organ, only: [:show, :edit, :update, :redirect, :destroy]
    before_action :set_new_organ, only: [:index, :new, :create]
    before_action :set_role, only: [:new]
    before_action :set_roles, only:[:index, :create]

    def index
      q_params = {}
      #q_params.merge! provider_id: [current_organ.id, nil] if current_organ
      q_params.merge! 'who_roles.role_id' => params[:role_id] if params[:role_id].present?

      @created_organs = current_user.created_organs.includes(:organ_domains).default_where(q_params).order(id: :desc)
      @accounts = current_user.accounts.each_with_object({}) { |k, h| h[k] = k.organs.where.not(id: current_user.created_organ_ids).default_where(q_params) }
      @accounts.merge! current_user.oauth_users.each_with_object({}) { |k, h| h[k] = k.organs.where.not(id: current_user.created_organ_ids).default_where(q_params) }
    end

    def create
      @member = @organ.members.build(identity: current_authorized_token.identity)
      @member.wechat_openid = current_authorized_token.uid if @member.respond_to? :wechat_openid

      if @organ.save
        render :create, locals: { model: @organ }
      else
        render :new, locals: { model: @organ }, status: :unprocessable_entity
      end
    end

    def redirect
      member = current_user.members.find_by(organ_id: @organ.id)
      redirect_to({ controller: '/me/home', host: @organ.admin_host, auth_token: member.auth_token }, allow_other_host: true)
    end

    private
    def set_organ
      @organ = current_user.organs.find(params[:id])
    end

    def set_new_organ
      @organ = current_user.created_organs.build(organ_params)
      if params[:role_id].present?
        @organ.role_whos.build(role_id: params[:role_id])
      end
    end

    def set_role
      if params[:role_id].present?
        @role = Roled::Role.find params[:role_id]
      end
    end

    def set_roles
      if params[:role_id].present?
        @roles = Roled::Role.visible.where(id: params[:role_id])
      else
        @roles = Roled::Role.visible.where.not(tip: nil)
      end
    end

    def organ_params
      _p = params.fetch(:organ, {}).permit(
        :name,
        :logo,
        role_whos_attributes: {}
      )
      _p.merge! provider_id: [current_organ.id, nil] if current_organ
    end

  end
end
