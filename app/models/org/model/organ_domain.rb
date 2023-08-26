module Org
  module Model::OrganDomain
    extend ActiveSupport::Concern

    included do
      attribute :subdomain, :string
      attribute :domain, :string, default: Rails.application.routes.default_url_options[:host]
      attribute :port, :string, default: Rails.application.routes.default_url_options[:port]
      attribute :host, :string
      attribute :identifier, :string, index: true
      attribute :default, :boolean, default: false
      attribute :beian, :string, comment: '备案号'

      enum scheme: {
        http: 'http',
        https: 'https'
      }, _default: Rails.application.routes.default_url_options[:protocol].presence || 'https'

      enum kind: {
        frontend: 'frontend',
        backend: 'backend',
        mp: 'mp'
      }, _default: 'frontend'

      belongs_to :organ

      validates :identifier, uniqueness: true

      after_initialize :init_subdomain, if: -> { new_record? && subdomain.nil? }
      before_validation :compute_identifier, if: -> { (changes.keys & ['domain', 'subdomain', 'port', 'host']).present? }
      after_update :set_default, if: -> { default? && saved_change_to_default? }
    end

    def set_default
      self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(default: false)
    end

    def compute_identifier
      self.host = [subdomain.presence, domain].compact.join('.')
      self.identifier = [host, port.presence].compact.join(':')
    end

    def init_subdomain
      if backend?
        self.subdomain = ['admin', organ_id].join('-')
      elsif mp?
        self.subdomain = ['mp', organ_id].join('-')
      else
        self.subdomain = ['org', organ_id].join('-')
      end
      compute_identifier
    end

    def options
      r = {
        host: host || Rails.application.routes.default_url_options[:host],
        port: port || Rails.application.routes.default_url_options[:port],
        protocol: scheme.presence || Rails.application.routes.default_url_options[:protocol]
      }
      r.delete(:port) if r[:port].blank? || r[:port] == '80'
      r
    end

    def url
      URI::Generic.build(
        host: host,
        scheme: scheme,
        port: port
      ).to_s
    end

  end
end
