module Org
  class Me::MembersController < Me::BaseController
    include Org::Layout::Me
    before_action :set_app
    before_action :set_member, only: [:show, :edit, :update, :destroy, :qrcodes]

    def qrcodes
      @scene = @member.invite_scene!(@app)
      if @scene.tag
        @requests = @scene.tag.requests.includes(:wechat_user).page(params[:page])
      else
        @requests = Wechat::Request.none.page(params[:page])
      end
    end

    private
    def set_app
      @app = current_organ.provider.app
    end

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
