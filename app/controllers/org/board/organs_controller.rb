module Org
  class Board::OrgansController < Board::BaseController
    before_action :set_organ, only: [:show, :edit, :update, :destroy]

    def index
      @organs = current_user.organs
      if @organs.blank?
        @member = current_user.members.build
        @organ = @member.build_organ
        render :new
      else
        render 'index'
      end
    end

    def new
      @organ = Organ.new
      @organ.who_roles.build(role_id: params[:role_id]) if params[:role_id].present?
    end

    def create
      @organ = Organ.new(organ_params)
      @member = @organ.members.build(owned: true)
      @member.account = current_account

      unless @organ.save
        render :new, locals: { model: @organ }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @organ.assign_attributes(organ_params)

      unless @organ.save
        render :edit, locals: { model: @organ }, status: :unprocessable_entity
      end
    end

    def destroy
      @organ.destroy
    end

    private
    def set_member
      @member = current_user.members.find params[:member_id]
    end

    def set_organ
      @organ = current_user.organs.find(params[:id])
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
