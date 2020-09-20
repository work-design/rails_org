module RailsOrg::Organ
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :domain, :string
    attribute :name_short, :string
    attribute :organ_uuid, :string
    attribute :address, :string
    attribute :timezone, :string
    attribute :locale, :string
    attribute :limit_wechat, :integer, default: 1
    attribute :members_count, :integer, default: 0
    attribute :official, :boolean, default: false, comment: '是否官方'
    attribute :joinable, :boolean, default: false, comment: '是否可搜索并加入'

    has_taxons :area
    belongs_to :area, optional: true

    has_many :supports, -> { where(department_id: nil) }, dependent: :destroy
    has_many :departments, dependent: :destroy
    has_many :members, dependent: :destroy
    has_many :super_job_titles, dependent: :destroy
    accepts_nested_attributes_for :members

    has_one_attached :logo

    scope :official, -> { where(official: true) }

    validates :name, presence: true
    validates :organ_uuid, uniqueness: true
    validates :domain, uniqueness: true, allow_blank: true

    after_initialize if: :new_record? do
      self.organ_uuid ||= UidHelper.nsec_uuid('ORG')
    end
  end

  def subdomain_code
    ['org', id].join('-')
  end

  def subdomain
    [subdomain_code, RailsCom.config.subdomain].compact.join('.')
  end

  def host(sub = subdomain)
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

  def admin?
    Array(cached_role_ids).compact.blank? && official?
  end

end
