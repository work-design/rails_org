module Org
  module Controller::Admin
    extend ActiveSupport::Concern

    def require_org_member
      return if current_member
      return if current_organ && current_organ.self_and_ancestor_ids.include?(current_member&.organ_id)

      if current_authorized_token
        render 'require_org_member'
      else
        require_user
      end
    end

    def current_oauth_app
      return @current_oauth_app if defined? @current_oauth_app
      if request.variant.include?(:work_wechat)
        @current_oauth_app = current_organ.corps.where.not(agentid: nil).take
      else
        @current_oauth_app = current_organ.provider.app
      end

      logger.debug "\e[35m  Current Admin Oauth App: #{@current_oauth_app&.base_class_name}/#{@current_oauth_app&.id}  \e[0m"
      @current_oauth_app
    end

  end
end
