module Org
  module Controller::Application
    extend ActiveSupport::Concern

    included do
      helper_method :current_organ, :current_organ_domain, :current_member, :other_organs, :default_platform_params
    end

    def current_member
      return @current_member if defined?(@current_member)

      @current_member =
        (defined?(current_wechat_user) && current_wechat_user && current_wechat_user.members.find_by(organ_id: current_organ&.self_and_ancestor_ids)) ||
        (current_account && current_account.members.find_by(organ_id: current_organ&.self_and_ancestor_ids)) ||
        defined?(current_corp_user) && current_corp_user&.member ||
        (current_user && current_user.members.find_by(organ_id: current_organ&.self_and_ancestor_ids)) ||
        defined?(current_authorized_token) && current_authorized_token&.mocked_member

      if @current_member
        logger.debug "\e[35m  Login as member: #{@current_member.name}(#{@current_member.id})  \e[0m"
      else
        logger.debug "\e[35m  member is missing  \e[0m"
      end
      @current_member
    end

    def current_organ
      return @current_organ if defined?(@current_organ)

      if params[:org_id] && params[:org_id].start_with?('org_')
        r = params[:org_id].delete_prefix('org_')
        @current_organ = Organ.find r
      elsif current_organ_domain
        @current_organ = @current_organ_domain.organ
      end
      logger.debug "\e[35m  Login as organ: #{@current_organ&.name}, ID: #{@current_organ&.id}  \e[0m"
      @current_organ
    end

    def current_organ_domain
      return @current_organ_domain if defined?(@current_organ_domain)
      @current_organ_domain = OrganDomain.annotate('get organ domain in org application').find_by(host: request.host)
    end

    def other_organs
      if current_organ
        current_user.organs.where.not(id: current_organ.id)
      else
        current_user.organs
      end
    end

    def default_params
      if current_organ
        { organ_id: current_organ.id }
      else
        super
      end
    end

    def default_form_params
      if current_organ
        { organ_id: current_organ.id }
      else
        super
      end
    end

    def default_filter_params
      if current_organ
        { organ_id: current_organ.self_and_descendant_ids }
      else
        default_params
      end
    end

    def default_ancestors_params
      if current_organ
        { organ_id: current_organ.self_and_ancestor_ids }
      else
        default_params
      end
    end

    def default_platform_params
      if current_organ
        { organ_id: [current_organ.id, nil] }
      else
        { organ_id: nil }
      end
    end

  end
end
