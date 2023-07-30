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
      attribute :code, :string
      attribute :service_url, :string, comment: '客服 url'
      attribute :redirect_controller, :string, default: '/home'
      attribute :redirect_action, :string, default: 'index', comment: '默认跳转'

      has_taxons :area
      belongs_to :area, class_name: 'Profiled::Area', optional: true
      belongs_to :creator, class_name: 'Auth::User', optional: true
      belongs_to :provider, class_name: 'Org::Organ', optional: true

      has_many :organs, class_name: self.name, primary_key: :provider_id
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
    end

    def address_detail
      "#{area&.full_name} #{address}"
    end

    def host
      domain = organ_domains.find(&:frontend?) || organ_domains.create
      domain.identifier
    end

    def url_options(request = nil)
      if request.is_a? ActionDispatch::Request
        cur = { host: request.host, protocol: request.scheme }
        cur.merge! port: request.port.to_s unless request.port.to_s == '80'
        return cur if organ_domains.map(&:options).include?(cur)
      end

      od = organ_domains.find(&:frontend?) || organ_domains.create
      return od.options if od

      {}
    end

    def admin_host
      admin_domain = organ_domains.find(&:backend?) || organ_domains.create(kind: 'backend')
      admin_domain.identifier
    end

    def admin_url_options(request = nil)
      if request.is_a? ActionDispatch::Request
        cur = { host: request.host, protocol: request.scheme }
        cur.merge! port: request.port.to_s unless request.port.to_s == '80'
        return cur if organ_domains.map(&:options).include?(cur)
      end

      od = organ_domains.find(&:backend?) || organ_domains.create(kind: 'backend')
      return od.options if od

      {}
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
