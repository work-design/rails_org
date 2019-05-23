module RailsOrg::Member
  extend ActiveSupport::Concern
  included do
    has_taxons :department

    attribute :experience, :string
    attribute :attendance_number, :string

    belongs_to :user, optional: true
    belongs_to :account, -> { where(confirmed: true) }, primary_key: :identity, foreign_key: :identity, optional: true
    
    has_many :member_departments, dependent: :delete_all
    has_many :departments, through: :member_departments
    has_many :job_titles, through: :member_departments
    has_many :organs, through: :member_departments
    accepts_nested_attributes_for :member_departments
    accepts_nested_attributes_for :organs
    
    has_many :leading_departments, class_name: 'Department', foreign_key: :leader_id
    
    has_many :organ_grants, dependent: :delete_all

    has_one :resign
    has_one :profile, through: :user
    has_one :tutorial, ->{ order(created_at: :desc) }, dependent: :nullify
    has_one :tutor, through: :tutorial
    has_many :tutorials, dependent: :nullify
    has_many :tutorings, class_name: 'Tutorial', foreign_key: :tutor_id
    has_many :tutees, through: :tutorings, source: :member
    has_many :job_transfers, dependent: :destroy

    has_one_attached :avatar
    has_one_attached :resume
    
    #before_save :sync_tutorials, if: -> { join_on_changed? }
    before_save :sync_account_user, if: -> { identity_changed? }
  end

  def sync_account_user
    self.user_id = account&.user_id
  end

  def direct_follower_ids
    return @direct_follower_ids if defined?(@direct_follower_ids)
    direct_ids = member_departments.map do |md|
      md.direct_followers.pluck(:member_id)
    end
    direct_ids << self.id
    @direct_follower_ids = direct_ids.flatten.uniq
  end

  def direct_followers
    Member.where(id: direct_follower_ids)
  end

  def all_follower_ids
    return @all_follower_ids if defined?(@all_follower_ids)
    all_ids = member_departments.map do |md|
      md.all_followers.pluck(:member_id)
    end
    all_ids << self.id
    @all_follower_ids = all_ids.flatten.uniq
  end

  def all_followers
    Member.where(id: all_follower_ids)
  end

  def organ_token
    if super
      return super
    else
      self.organ_grants.delete_all
      create_organ_grant
    end

    organ_grant.token
  end

  def get_organ_token(organ_id)
    grant = self.organ_grants.valid.find_by(organ_id: organ_id)
    unless grant
      self.organ_grants.where(organ_id: organ_id).delete_all
      grant = organ_grants.create(organ_id: organ_id)
    end
    grant
  end

  def leading_members
    Member.where(department_id: leading_department.self_and_descendant_ids)
  end

  def leading_member_ids
    leading_members.pluck(:id)
  end

  def leading_highest_department
    leading_departments = self.leading_departments
    unless leading_departments.empty?
      leading_departments = self.leading_departments.sort_by(&:depth)
    end
    leading_departments.first
  end

  def timezone
    user.timezone || office.timezone || 'Beijing'
  end

  def locale
    user.locale || office.locale.presence || I18n.default_locale
  end

  def avatar_url
    avatar.service_url if avatar.attachment.present?
  end

end
