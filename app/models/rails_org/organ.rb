module RailsOrg::Organ
  extend ActiveSupport::Concern
  included do
    attribute :limit_wechat, :integer, default: 1
    attribute :name_short, :string

    has_taxons :area
    belongs_to :area
    
    has_many :supports, -> { where(department_id: nil) }, dependent: :destroy
    has_many :departments, dependent: :destroy
    has_many :rooms, dependent: :delete_all
    has_many :member_departments, dependent: :destroy
    has_many :members, through: :member_departments
    has_many :organ_grants, dependent: :delete_all
    
    has_one_attached :logo

    validates :name, presence: true

    before_validation do
      self.organ_uuid ||= UidHelper.nsec_uuid('ORG')
    end
  end

  def get_organ_token(user)
    if user.is_a?(User)
      params = { user_id: user.id }
    else
      params = { member_id: user.id }
    end
    grant = self.organ_grants.valid.find_by(params)
    unless grant
      self.organ_grants.where(params).delete_all
      grant = organ_grants.create(params)
    end
    grant
  end

  def generate_token(**options)
    JwtHelper.generate_jwt_token(id, organ_uuid, options)
  end

end
