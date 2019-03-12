class Member < ApplicationRecord
  attribute :department_ancestors
  include RailsRoleUser
  include RailsTradeBuyer
  include RailsTradeUser
  include RailsNoticeReceivable

  belongs_to :parent, class_name: self.name, foreign_key: :parent_id
  has_many :children, class_name: self.name, foreign_key: :parent_id


  belongs_to :user, foreign_key: :email, primary_key: :email, optional: true
  belongs_to :office, optional: true, counter_cache: true
  belongs_to :department, optional: true, counter_cache: true

  belongs_to :buyer, class_name: self.name, foreign_key: :id, optional: true

  has_one :teacher
  has_one :resign
  has_one :profile, through: :user
  has_one :tutorial, ->{ order(created_at: :desc) }, dependent: :nullify
  has_one :tutor, through: :tutorial
  has_one :leading_office, class_name: 'Office', foreign_key: :leader_id
  has_one :leading_department, class_name: 'Department', foreign_key: :leader_id
  has_many :leading_departments, class_name: 'Department', foreign_key: :leader_id

  has_many :lesson_members, dependent: :destroy
  has_many :lessons, through: :lesson_members
  has_many :tutorials, dependent: :nullify
  has_many :tutorings, class_name: 'Tutorial', foreign_key: :tutor_id
  has_many :tutees, through: :tutorings, source: :member
  has_many :job_transfers, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :review_exams, class_name: 'Exam', foreign_key: :reviewer_id, inverse_of: 'reviewer'
  has_many :expense_members, dependent: :nullify
  has_many :expenses, through: :expense_members
  has_many :created_expenses, class_name: 'Expense', foreign_key: :creator_id
  has_many :member_badges, dependent: :nullify
  has_many :badges, through: :member_badges

  has_many :journal_transfers
  has_many :journal_rels
  has_many :journals, through: :journal_rels
  has_many :recruitment_plans


  scope :china_sl, -> { default_where('office.country': 'China', id: EditDepartment.roots.first.children.pluck(:leader_id)) }
  scope :editors, -> { default_where('department.type': 'EditDepartment') }

  validates :user_id, uniqueness: true, allow_blank: true

  before_save :sync_department_id, if: -> { department_ancestors_changed? }
  #before_save :sync_tutorials, if: -> { join_on_changed? }


  def section
    if group
      group.parent
    elsif self.department&.depth == 1
      self.department
    end
  end

  def group
    self.department if self.department&.depth == 2
  end

  def exam_reviewers
    Member.china_sl.default_where('leading_department.id-not': self.department&.ancestor_ids)
  end

  def leading_section
    leading_departments.detect { |department| department.section? }
  end

  def leading_group
    leading_departments.detect { |department| department.grouping? }
  end

  def leading_section_members
    if leading_section
      Member.where(department_id: leading_section.self_and_descendant_ids, enabled: true)
    end
  end

  def leading_group_members
    if leading_group
      Member.where(department_id: leading_group.id, enabled: true)
    end
  end

  def leading_highest_department
    leading_departments = self.leading_departments
    unless leading_departments.empty?
      leading_departments = self.leading_departments.sort_by {|a| a.depth}
    end
    leading_departments.first
  end

  Support.kinds.keys.each do |role|
    define_method("#{role}") do
      r = Support.where(member_id: self.id, kind: role).first&.supporter
      unless r
        r = self.department&.send(role)
      end
      unless r
        r = self.office&.send(role)
      end
      r
    end
  end

  def timezone
    user.timezone || office.timezone || 'Beijing'
  end

  def locale
    user.locale || office.locale.presence || I18n.default_locale
  end

  def endearing_name
    name.split(/\s+/).first
  end

  def parent
    if super
      super
    else
      leader
    end
  end

  private
  def sync_department_id
    self.department_id = self.department_ancestors.values.compact.last
  end

end
