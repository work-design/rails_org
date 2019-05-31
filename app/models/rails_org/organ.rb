module RailsOrg::Organ
  extend ActiveSupport::Concern
  included do
    attribute :limit_wechat, :integer, default: 1
    attribute :name_short, :string

    has_taxons :area
    belongs_to :area
    belongs_to :creator, class_name: 'Member', optional: true
    
    has_many :supports, -> { where(department_id: nil) }, dependent: :destroy
    has_many :departments, dependent: :destroy
    has_many :members, dependent: :destroy
    has_many :rooms, dependent: :delete_all
    has_many :organ_grants, dependent: :delete_all
    
    has_one_attached :logo

    validates :name, presence: true
    validates :organ_uuid, uniqueness: true

    before_validation do
      self.organ_uuid ||= UidHelper.nsec_uuid('ORG')
    end
    after_save :sync_member_departments, if: -> { creator_id && saved_change_to_creator_id? }
  end

  def get_organ_grant(user)
    if user.is_a?(User)
      params = { user_id: user.id }
    else
      params = { member_id: user.id }
    end
    grant = self.organ_grants.find_or_create_by(params)
    unless grant.valid_period?
      grant.update_token!
    end
    grant
  end

  def generate_token(**options)
    JwtHelper.generate_jwt_token(id, organ_uuid, options)
  end
  
  def sync_member_departments
    self.member_departments.create(member_id: creator_id)
    role = Role.find_by(who_type: 'Member', code: RailsOrg.config.super_role_code)
    creator.who_roles.create(role_id: role.id) if role
  end

end
