module RailsOrg::Organ
  extend ActiveSupport::Concern
  included do
    attribute :name, :string
    attribute :code, :string
    attribute :name_short, :string
    attribute :organ_uuid, :string
    attribute :address, :string
    attribute :timezone, :string
    attribute :locale, :string
    attribute :limit_wechat, :integer, default: 1
    attribute :members_count, :integer, default: 0

    has_taxons :area
    belongs_to :area, optional: true

    has_many :supports, -> { where(department_id: nil) }, dependent: :destroy
    has_many :departments, dependent: :destroy
    has_many :members, dependent: :destroy
    has_many :rooms, dependent: :delete_all
    has_many :organ_grants, dependent: :delete_all
    has_many :organ_tokens, dependent: :delete_all
    has_many :super_job_titles, dependent: :destroy
    accepts_nested_attributes_for :members

    has_one_attached :logo

    validates :name, presence: true
    validates :code, presence: true
    validates :organ_uuid, uniqueness: true

    before_validation do
      self.code ||= UidHelper.sec_uuid('CO')
      self.organ_uuid ||= UidHelper.nsec_uuid('ORG')
    end
  end

  def subdomain
    [self.code, RailsOrg.config.subdomain].join('.')
  end

  def get_organ_grant(user)
    if user.is_a?(User)
      params = { user_id: user.id }
    elsif user.is_a?(Member)
      params = { member_id: user.id }
    else
      params = {}
    end
    grant = self.organ_grants.find_or_create_by(params)
    unless grant.valid_period?
      grant.update_token!
    end
    grant
  end

end
