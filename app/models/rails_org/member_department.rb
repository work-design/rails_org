module RailsOrg::MemberDepartment
  extend ActiveSupport::Concern
  included do
    has_taxons :department
    attribute :department_descendant_ids, :integer, array: true
    
    belongs_to :member
    belongs_to :department, counter_cache: true
    belongs_to :office, optional: true
    belongs_to :job_title, optional: true
    
    before_save :sync_department_and_office
    after_save_commit :sync_department_members_count, if: -> { saved_change_to_department_id? }
  end
  
  def direct_followers
    self.class.default_where(department_id: department_id, office_id: office.self_and_descendant_ids, 'grade-gt': self.grade)
  end
  
  def all_followers
    if office
      office_ids = office.self_and_descendant_ids
    else
      office_ids = [nil]
      office_ids += Office.where(organ_id: department.organ_id).pluck(:id)
    end
    self.class.default_where(department_id: [department.self_and_descendant_ids], office_id: office_ids, 'grade-gt': self.grade)
  end
  
  def set_major
    self.class.transaction do
      self.update(major: true)
      self.class.where.not(id: self.id).where(member_id: self.member_id).update_all(major: false)
    end
  end

  def sync_department_and_office
    if department && department_id_changed?
      self.department_descendant_ids = self.department.self_and_descendant_ids
    end
    if job_title && job_title_id_changed?
      self.department_root_id = job_title.department_id
      self.grade = job_title.grade
    end
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

end
