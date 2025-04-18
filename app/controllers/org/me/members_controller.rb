module Org
  class Me::MembersController < Me::BaseController
    include Org::Layout::Me
    before_action :set_member, only: [:show, :edit, :update, :destroy, :qrcodes]

    def qrcodes
      if @member.inviter
        @scene = @member.invite_member!
        @requests = @scene.requests.includes(:wechat_user).page(params[:page])
      else
        render :qrcode
      end
    end

    private
    def set_member
      @member = current_member
    end

    def member_params
      params.fetch(:member, {}).permit(
        :name,
        :avatar
      )
    end

  end
end
