module Org
  module Controller::Application
    extend ActiveSupport::Concern

    included do
      helper_method :current_organ, :current_member, :other_organs
    end

    def current_title
      if current_organ
        current_organ.name
      else
        t('.title', default: :site_name)
      end
    end

    def current_member
      return @current_member if defined?(@current_member)

      if current_authorized_token
        @current_member = current_authorized_token.members.find_by(organ_id: current_organ&.id)
      end
      logger.debug "  \e[35mLogin as member: #{@current_member&.id}\e[0m"
      @current_member
    end

    def current_organ
      return @current_organ if defined?(@current_organ)

      if current_organ_domain
        @current_organ = @current_organ_domain.organ
      end
      logger.debug "  \e[35mLogin as organ: #{@current_organ&.name}, ID: #{@current_organ&.id}\e[0m"
      @current_organ
    end

    def current_organ_domain
      return @current_organ_domain if defined?(@current_organ_domain)

      @current_organ_domain = OrganDomain.annotate('get organ domain in org application').find_by(identifier: request.host_with_port)
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
