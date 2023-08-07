module Org
  class Admin::OrganDomainsController < Admin::BaseController
    before_action :set_organ
    before_action :set_organ_domain, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_organ_domain, only: [:new, :create]

    def index
      @organ_domains = @organ.organ_domains.page(params[:page])
    end

    private
    def set_organ
      @organ = Organ.find params[:organ_id]
    end

    def set_organ_domain
      @organ_domain = @organ.organ_domains.find(params[:id])
    end

    def set_new_organ_domain
      @organ_domain = @organ.organ_domains.build(organ_domain_params)
    end

    def organ_domain_params
      params.fetch(:organ_domain, {}).permit(
        :domain,
        :port,
        :subdomain,
        :host,
        :default,
        :appid,
        :scheme,
        :kind,
        :beian
      )
    end

  end
end
