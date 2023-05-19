module Org
  module Controller::Application
    extend ActiveSupport::Concern

    included do
      helper_method :current_organ, :current_member, :other_organs
    end

    def current_member
      return @current_member if defined?(@current_member)

      @current_member = (current_user && current_user.members.find_by(organ_id: current_organ&.id)) || current_corp_user&.member
      logger.debug "\e[35m  Login as member: #{@current_member&.id}  \e[0m"
      @current_member
    end

    def current_organ
      return @current_organ if defined?(@current_organ)

      if params[:org_id] && params[:org_id].start_with?('org_')
        r = params[:org_id].delete_prefix('org_')
        @current_organ = Organ.find r
      elsif current_organ_domain
        @current_organ = @current_organ_domain.organ
      else
        @current_organ = current_user && current_user.organs.take
      end
      logger.debug "\e[35m  Login as organ: #{@current_organ&.name}, ID: #{@current_organ&.id}  \e[0m"
      @current_organ
    end

    def current_organ_domain
      return @current_organ_domain if defined?(@current_organ_domain)

      @current_organ_domain = OrganDomain.annotate('get organ domain in org application').find_by(identifier: request&.host_with_port)
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

  end
end
