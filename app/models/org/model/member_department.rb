module Org
  module Model::MemberDepartment
    extend ActiveSupport::Concern

    included do
      has_taxons :department

      attribute :department_root_id, :integer
      attribute :superior_id, :integer
      attribute :grade, :integer, default: 0

      belongs_to :member
      belongs_to :department, counter_cache: true, inverse_of: :member_departments
      belongs_to :job_title
      has_many :descendant_hierarchies, class_name: 'DepartmentHierarchy', foreign_key: :ancestor_id, primary_key: :department_id
      has_many :self_and_descendants, ->(o){ default_where('grade-gt': o.grade) }, through: :descendant_hierarchies, source: :member_department
      has_many :members, through: :self_and_descendants, source: :member

      validates :department_id, uniqueness: { scope: :member_id }

      before_save :sync_from_job_title, if: -> { (changes.keys & ['job_title_id', 'department_id']).present? }
      after_save_commit :sync_department_members_count, if: -> { saved_change_to_department_id? }
      after_save_commit :sync_role_ids
    end

    def direct_followers
      self.class.default_where(department_id: department_id, 'grade-gt': self.grade)
    end

    def job_title_options
      if department
        JobTitle.where(department_root_id: department.root.id)
      else
        JobTitle.none
      end
    end

    def sync_from_job_title
      self.department_id = job_title.department_id
      self.grade = job_title.grade

      self.superior_id = department.superior_id
      self.department_root_id = department.root.id
    end

    def sync_department_members_count
      self.class.transaction do
        Department.increment_counter :all_member_departments_count, department.self_and_ancestor_ids

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
end
