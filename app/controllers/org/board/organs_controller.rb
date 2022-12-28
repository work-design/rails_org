module Org
  class Board::OrgansController < Board::BaseController
    before_action :set_organ, only: [:show, :edit, :update, :destroy]
    before_action :set_new_organ, only: [:new, :create]

    def index
      @organs = current_account.organs.includes(:organ_domains)

      if @organs.blank?
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

    def member_params
      p = params.fetch(:member, {}).permit(
        :identity
      )
      p.merge! owned: true
      unless p[:identity]
        p.merge! identity: current_account.identity
      end
      p
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
