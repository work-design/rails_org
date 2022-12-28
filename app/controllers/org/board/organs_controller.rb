module Org
  class Board::OrgansController < Board::BaseController
    before_action :set_organ, only: [:show, :edit, :update, :destroy]
    before_action :set_new_organ, only: [:new, :create]
    before_action :set_role, only: [:new, :index]

    def index
      q_params = {}
      q_params.merge! 'who_roles.role_id' => params[:role_id] if params[:role_id].present?

      @organs = current_account.organs.includes(:organ_domains).default_where(q_params)
      if @organs.blank?
        set_new_organ
        render :new
      else
        render 'index'
      end
    end

    private
    def set_organ
      @organ = current_user.organs.find(params[:id])
    end

    def set_new_organ
      @member = current_account.members.build(owned: true)
      @organ = @member.build_organ(organ_params)
      @organ.who_roles.build(role_id: params[:role_id]) if params[:role_id].present?
    end

    def set_role
      @role = Roled::Role.find params[:role_id] if params[:role_id].present?
    end

    def organ_params
      params.fetch(:organ, {}).permit(
        :name,
        :logo,
        who_roles_attributes: {}
      )
    end

  end
end
