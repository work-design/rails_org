module RailsOrg::OrganDomain
  extend ActiveSupport::Concern

  included do
    attribute :subdomain, :string
    attribute :domain, :string
    attribute :port, :string
    attribute :host, :string
    attribute :appid, :string

    belongs_to :organ
    belongs_to :wechat_app, foreign_key: :appid, primary_key: :appid, optional: true
  end

end
