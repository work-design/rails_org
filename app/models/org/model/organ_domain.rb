module Org
  module Model::OrganDomain
    extend ActiveSupport::Concern

    included do
      attribute :subdomain, :string
      attribute :domain, :string, default: Rails.application.routes.default_url_options[:host]
      attribute :port, :string, default: Rails.application.routes.default_url_options[:port]
      attribute :host, :string
      attribute :identifier, :string, index: true
      attribute :appid, :string
      attribute :default, :boolean, default: false
      attribute :beian, :string, comment: '备案号'

      enum scheme: {
        http: 'http',
        https: 'https'
      }, _default: 'https'

      belongs_to :organ
      belongs_to :wechat_app, class_name: 'Wechat::App', foreign_key: :appid, primary_key: :appid, optional: true

      validates :identifier, uniqueness: true

      after_initialize :init_subdomain, if: -> { new_record? && subdomain.nil? }
      before_validation :compute_identifier, if: -> { (changes.keys & ['domain', 'subdomain', 'port', 'host']).present? }
      after_update :set_default, if: -> { default? && saved_change_to_default? }
      after_save :sync_domain_to_organ, if: -> { saved_change_to_identifier? || (default? && saved_change_to_default?) }
    end

    def set_default
      self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(default: false)
    end

    def sync_domain_to_organ
      organ.update domain: identifier
    end

    def compute_identifier
      self.host = [subdomain.presence, domain].compact.join('.')
      self.identifier = [host, port.presence].compact.join(':')
    end

    def init_subdomain
      self.subdomain = ['org', organ_id].join('-')
      compute_identifier
    end

    def options
      {
        host: host,
        port: port.presence || '80',
        protocol: scheme.presence || 'https'
      }
    end

  end
end
