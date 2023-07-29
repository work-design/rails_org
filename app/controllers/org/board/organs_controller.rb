module Org
  class Board::OrgansController < Board::BaseController
    before_action :set_organ, only: [:show, :edit, :update, :destroy]
    before_action :set_new_organ, only: [:new, :create]
    before_action :set_role, only: [:new]
    before_action :set_roles, only:[:index]

    def index
      q_params = {
        provider_id: current_organ&.id
      }
      q_params.merge! 'who_roles.role_id' => params[:role_id] if params[:role_id].present?

      @organs = current_user.organs.includes(:organ_domains).default_where(q_params).order(id: :desc)
    end

    private
    def set_organ
      @organ = current_user.organs.find(params[:id])
    end

    def set_new_organ
      @organ = current_user.created_organs.build(organ_params)
      @organ.who_roles.build(role_id: params[:role_id]) if params[:role_id].present?
    end

    def set_role
      if params[:role_id].present?
        @role = Roled::Role.find params[:role_id]
      end
    end

    def set_roles
      if params[:role_id].present?
        @roles = Roled::OrganRole.visible.where(id: params[:role_id])
      else
        @roles = Roled::OrganRole.visible
      end
    end

    def organ_params
      p = params.fetch(:organ, {}).permit(
        :name,
        :logo,
        who_roles_attributes: {}
      )
      p.merge! provider_id: current_organ&.id
    end

  end
end
