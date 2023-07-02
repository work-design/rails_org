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
      attribute :code, :string
      attribute :service_url, :string, comment: '客服 url'
      attribute :redirect_controller, :string, default: '/home'
      attribute :redirect_action, :string, default: 'index', comment: '默认跳转'

      has_taxons :area
      belongs_to :area, class_name: 'Profiled::Area', optional: true

      has_one :organ_domain, -> { where(default: true) }, inverse_of: :organ
      has_many :supports, -> { where(department_id: nil) }, dependent: :destroy_async
      has_many :departments, dependent: :destroy_async
      has_many :members, dependent: :destroy_async
      has_many :super_job_titles, dependent: :destroy_async
      has_many :organ_domains, dependent: :destroy_async
      accepts_nested_attributes_for :members

      has_one_attached :logo

      scope :official, -> { where(official: true) }

      validates :name, presence: true
      validates :code, uniqueness: true, allow_blank: true

      before_save :init_organ_domain, if: -> { domain.blank? }
    end

    def host
      if domain.blank?
        init_organ_domain
        save
      end
      # todo deal with port
      ActionDispatch::Http::URL.url_for(
        host: domain || Rails.application.routes.default_url_options[:host],
        protocol: Rails.application.routes.default_url_options[:protocol]
      )
    end

    def address_detail
      "#{area&.full_name} #{address}"
    end

    def url_options(request = nil)
      if request.is_a? ActionDispatch::Request
        cur = { host: request.host, protocol: request.scheme }
        cur.merge! port: request.port.to_s unless request.port.to_s == '80'
        return cur if organ_domains.map(&:options).include?(cur)
      end

      od = organ_domains.find(&:default) || organ_domains.take
      return od.options if od

      {}
    end

    def init_organ_domain
      organ_domain || build_organ_domain
    end

    def domains
      organ_domains.pluck(:identifier)
    end

    def admin?
      official?
    end

    def redirect_path
      Rails.application.routes.url_for(
        controller: redirect_controller,
        action: redirect_action,
        only_path: true
      )
    end

  end
end
