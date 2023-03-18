module Org
  class Me::MembersController < Me::BaseController
    include Org::Layout::Me
    before_action :set_member, only: [:show, :edit, :update, :destroy, :qrcodes, :qrcode]

    def qrcodes
      @wechat_apps = Wechat::App.inviting.where(organ_id: current_organ.id)

      if @wechat_apps.size == 1
        @scene = @member.invite_scene(@wechat_apps[0])
        set_requests
      end
    end

    def qrcode
      app = Wechat::App.find(params[:app_id]) || current_wechat_app
      @scene = @member.invite_scene(app)
      set_requests
    end

    private
    def set_member
      @member = current_member
    end

    def set_requests
      if @scene.tag
        @requests = @scene.tag.requests.includes(:wechat_user).page(params[:page])
      else
        @requests = Wechat::Request.none.page(params[:page])
      end
    end

    def member_params
      params.fetch(:member, {}).permit(
        :name,
        :avatar
      )
    end

  end
end
