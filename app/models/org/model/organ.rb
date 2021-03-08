module Org
  module Model::Organ
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :name_short, :string
      attribute :address, :string
      attribute :members_count, :integer, default: 0
      attribute :official, :boolean, default: false, comment: '是否官方'
      attribute :joinable, :boolean, default: false, comment: '是否可搜索并加入'
      attribute :domain, :string

      has_taxons :area
      belongs_to :area, class_name: 'Profiled::Area', optional: true

      has_one :organ_domain, -> { where(default: true) }, inverse_of: :organ
      has_many :supports, -> { where(department_id: nil) }, dependent: :destroy
      has_many :departments, dependent: :destroy
      has_many :members, dependent: :destroy
      has_many :super_job_titles, dependent: :destroy
      has_many :organ_domains, dependent: :destroy
      accepts_nested_attributes_for :members

      has_one_attached :logo

      scope :official, -> { where(official: true) }

      validates :name, presence: true
    end

    def host
      if domain.blank?
        init_organ_domain
        save
      end
      # todo deal with port
      ActionDispatch::Http::URL.url_for(
        host: domain,
        protocol: Rails.application.routes.default_url_options[:protocol]
      )
    end

    def url_options
      od = organ_domain || organ_domains.take || build_organ_domain
      od.as_json(only: [:host, :port])
    end

    def init_organ_domain
      organ_domain || build_organ_domain
    end

    def domains
      organ_domains.pluck(:identifier)
    end

    def admin?
      Array(cached_role_ids).compact.blank? && official?
    end

  end
end
