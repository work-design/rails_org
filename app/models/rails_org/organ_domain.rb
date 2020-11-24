module RailsOrg::OrganDomain
  extend ActiveSupport::Concern

  included do
    attribute :subdomain, :string
    attribute :domain, :string, default: Rails.application.routes.default_url_options[:host]
    attribute :port, :string, default: Rails.application.routes.default_url_options[:port]
    attribute :host, :string
    attribute :identifier, :string
    attribute :appid, :string
    attribute :default, :boolean, default: false

    belongs_to :organ
    belongs_to :wechat_app, foreign_key: :appid, primary_key: :appid, optional: true

    validates :identifier, uniqueness: true

    before_validation :compute_identifier, if: -> { (changes.keys & ['domain', 'subdomain', 'port', 'host']).present? }
    after_update :set_default, if: -> { default? && saved_change_to_default? }
  end

  def set_default
    self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(default: false)
  end

  def compute_identifier
    self.host = [subdomain, domain].join('.')
    self.identifier = ActionDispatch::Http::URL.url_for(host: host, port: port, subdomain: subdomain, trailing_slash: true)
  end

  def subdomain
    code = ['org', id].join('-')
    sub = ActionDispatch::Http::URL.extract_subdomain RailsCom.config.host, 1
    [code, sub.presence].compact.join('.')
  end

  def host
    if domain.present?
      domain
    else

    end
  end

end
