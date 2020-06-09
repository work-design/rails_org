module RailsOrg::MemberDepartment
  extend ActiveSupport::Concern

  included do
    has_taxons :department

    attribute :department_root_id, :integer
    attribute :superior_id, :integer
    attribute :grade, :integer
    attribute :super_grade, :integer, default: 0

    belongs_to :member
    belongs_to :department, counter_cache: true, inverse_of: :member_departments, optional: true
    belongs_to :job_title, optional: true
    belongs_to :super_job_title, optional: true
    has_many :descendant_hierarchies, class_name: 'DepartmentHierarchy', foreign_key: :ancestor_id, primary_key: :department_id
    has_many :self_and_descendants, ->(o){ default_where('super_grade-lte': o.super_grade, 'grade-gt': o.grade) }, through: :descendant_hierarchies, source: :member_department
    has_many :members, through: :self_and_descendants, source: :member

    validates :department_id, uniqueness: { scope: :member_id }
    validates :job_title_id, presence: true, if: -> { department_id.blank? }
    validates :department_id, presence: true, if: -> { job_title_id.blank? }

    before_save :sync_from_job_title, if: -> { job_title_id_changed? || department_id_changed? }
    after_save_commit :sync_department_members_count, if: -> { saved_change_to_department_id? }
    after_save_commit :sync_role_ids
  end

  def direct_followers
    self.class.default_where(department_id: department_id, 'grade-gt': self.grade)
  end

  def same_job_titles
    if job_title
      job_title.same_job_titles
    elsif department
      ::JobTitle.where(department_root_id: department.root.id)
    else
      ::SuperJobTitle.where(organ_id: member.organ_id)
    end
  end

  def sync_from_job_title
    if super_job_title
      self.super_grade = super_job_title.grade
    elsif job_title
      self.department_id = job_title.department_id
      self.grade = job_title.grade
    end

    self.superior_id = department.superior_id
    self.department_root_id = self.department.root&.id
  end

  def sync_department_members_count
    self.class.transaction do
      if department
        Department.increment_counter :all_member_departments_count, department.self_and_ancestor_ids
      end
      if department_id_before_last_save
        depart = Department.find(department_id_before_last_save)
        Department.decrement_counter :all_member_departments_count, depart.self_and_ancestor_ids
      end
    end
  end

  def sync_role_ids
    r_ids = self.member.role_ids
    if job_title
      r_ids = r_ids | self.job_title.role_ids
    end
    self.member.role_ids = r_ids
  end

end
