module Org
  class Me::MembersController < Me::BaseController
    include Org::Layout::Me
    before_action :set_wechat_app, only: [:qrcodes]
    before_action :set_member, only: [:show, :edit, :update, :destroy, :qrcodes]

    def qrcodes
      @scene = @member.invite_scene!(@wechat_app)
      if @scene.tag
        @requests = @scene.tag.requests.includes(:wechat_user).page(params[:page])
      else
        @requests = Wechat::Request.none.page(params[:page])
      end
    end

    private
    def set_member
      @member = current_member
    end

    def set_wechat_app
      @wechat_app = Wechat::PublicApp.inviting.take
    end

    def member_params
      params.fetch(:member, {}).permit(
        :name,
        :avatar
      )
    end

  end
end
