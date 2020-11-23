module RailsOrg::OrganDomain
  extend ActiveSupport::Concern

  included do
    attribute :subdomain, :string
    attribute :domain, :string
    attribute :port, :string
    attribute :host, :string
    attribute :appid, :string
    attribute :default, :boolean, default: false

    belongs_to :organ
    belongs_to :wechat_app, foreign_key: :appid, primary_key: :appid, optional: true

    validates :domain, uniqueness: true, allow_blank: true
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
      ActionDispatch::Http::URL.url_for(
        host: Rails.application.routes.default_url_options[:host],
        port: Rails.application.routes.default_url_options[:port],
        subdomain: sub,
        trailing_slash: true
      )
    end
  end

end
