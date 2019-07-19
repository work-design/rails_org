module RailsOrg::MemberDepartment
  extend ActiveSupport::Concern
  included do
    has_taxons :department
    
    belongs_to :member
    belongs_to :department, counter_cache: true, inverse_of: :member_departments, optional: true
    belongs_to :job_title, optional: true
    has_many :descendant_hierarchies, class_name: 'DepartmentHierarchy', foreign_key: :ancestor_id, primary_key: :department_ids
    has_many :self_and_descendants, ->(o){ default_where('grade-gt': o.grade) }, through: :descendant_hierarchies, source: :member_department
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
      ::DepartmentJobTitle.where(organ_id: department.organ_id, department_id: department.self_and_ancestor_ids, super_job_title_id: nil)  # todo confirm super job title id is or not nil
    else
      ::SuperJobTitle.where(organ_id: member.organ_id)
    end
  end
  
  def set_major
    self.class.transaction do
      self.update(major: true)
      self.class.where.not(id: self.id).where(member_id: self.member_id).update_all(major: false)
    end
  end

  def sync_from_job_title
    if job_title
      if job_title.is_a?(SuperJobTitle)
        self.department_ids = job_title.department_ids
      else
        self.department_root_id = job_title.department_root_id
      end
      self.grade = job_title.grade
    else
      self.department_ids = []
      self.grade = nil
    end
    
    if department
      self.superior_id = department.superior_id
      self.department_root_id = self.department.root&.id
    else
      self.superior_id = nil
    end
    
    if department.nil? && job_title.nil?
      self.department_root_id = nil
    end
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
