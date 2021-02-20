module Org
  module Model::Member
    extend ActiveSupport::Concern

    included do
      delegate :url_helpers, to: 'Rails.application.routes'
      has_taxons :department

      attribute :identity, :string, index: true
      attribute :experience, :string
      attribute :attendance_number, :string
      attribute :owned, :boolean, default: false
      attribute :organ_root_id, :integer
      attribute :name, :string
      attribute :number, :string
      attribute :join_on, :date
      attribute :enabled, :boolean, default: true
      attribute :state, :string

      belongs_to :user, class_name: 'Auth::User', optional: true
      belongs_to :account, -> { where(confirmed: true) }, class_name: 'Auth::Account', primary_key: :identity, foreign_key: :identity, optional: true
      belongs_to :profile, ->(o){ where(organ_id: o.organ_id) }, class_name: 'Profiled::Profile', primary_key: :identity, foreign_key: :identity, optional: true

      belongs_to :organ, counter_cache: true, inverse_of: :members

      has_many :member_departments, dependent: :delete_all
      has_many :departments, through: :member_departments
      has_many :job_titles, through: :member_departments
      has_many :members, through: :member_departments, source: :members
      accepts_nested_attributes_for :member_departments, reject_if: :all_blank, allow_destroy: true
      accepts_nested_attributes_for :organ

      has_many :inferior_member_departments, class_name: 'Org::MemberDepartment', foreign_key: :superior_id, primary_key: :department_ids
      has_many :authorized_tokens, dependent: :nullify

      has_one :resign
      has_one :tutorial, ->{ order(created_at: :desc) }, dependent: :nullify
      has_one :tutor, through: :tutorial
      has_many :tutorials, dependent: :nullify
      has_many :tutorings, class_name: 'Org::Tutorial', foreign_key: :tutor_id
      has_many :tutees, through: :tutorings, source: :member
      #has_many :job_transfers, dependent: :destroy

      has_one_attached :avatar
      has_one_attached :resume

      scope :enabled, -> { where(enabled: true) }

      validates :identity, uniqueness: { scope: :organ_id }

      #before_save :sync_tutorials, if: -> { join_on_changed? }
      before_validation :sync_account_user, if: -> { identity_changed? }
      before_save :sync_avatar_from_user, if: -> { user_id_changed? }
      after_create :sync_member_roles, if: -> { owned? }
    end

    def admin?
      owned?
    end

    def grade
      member_departments.minimum(:grade)
    end

    def sync_account_user
      self.user = account&.user
    end

    def sync_avatar_from_user
      if user
        self.name ||= user.name
        self.avatar_blob ||= user.avatar_blob
      end
    end

    def init_user
      account || build_account
      account.user || account.build_user
      self.user = account.user

      self.class.transaction do
        self.save!
        account.save!
      end

      user
    end

    def direct_follower_ids
      member_departments.map do |md|
        md.direct_followers.pluck(:member_id)
      end.flatten.uniq
    end

    def direct_followers
      Member.where(id: direct_follower_ids)
    end

    def all_follower_ids
      (member_departments.map do |md|
        md.self_and_descendants.pluck(:member_id)
      end.flatten + [self.id]).uniq
    end

    def all_followers
      Member.where(id: all_lower_ids)
    end

    def lower_job_title_ids
      job_titles.map(&:lower_job_title_ids).flatten.uniq
    end

    def all_lower_ids
      MemberDepartment.where(job_title_id: lower_job_title_ids).pluck(:member_id)
    end

    def leader

    end

    def get_organ_grant
      at = account.authorized_token
      at.update member_id: self.id
      at
    end

    def mock_organ_grant(user_id)
      grant = self.organ_grants.find_or_create_by(user_id: user_id)
      unless grant.verify_token?
        grant.update_token!
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

    def avatar_url
      url_helpers.rails_blob_url(avatar) if avatar.attachment.present?
    end

    def sync_member_roles
      role = Role.default_where('who_types-any': 'Member', code: RailsOrg.config.super_role_code).take
      who_roles.create(role_id: role.id) if role
    end

  end
end
