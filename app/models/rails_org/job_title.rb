module RailsOrg::JobTitle
  extend ActiveSupport::Concern
  included do
    attribute :grade, :integer
    attribute :name, :string
    attribute :description, :string
    attribute :limit_number, :integer

    belongs_to :department
    belongs_to :department_root, class_name: 'Department'
    belongs_to :super_job_title, optional: true
    has_many :member_departments, dependent: :destroy
    has_many :members, through: :member_departments
    
    acts_as_list column: :grade, scope: :department_root_id
    
    default_scope -> { order(grade: :asc) }
    
    before_validation :init_department_root
    after_update_commit :sync_grade_member_departments, if: -> { saved_change_to_grade? }
  end
  
  def sync_grade_member_departments
    member_departments.update_all(grade: self.grade)
  end
  
  def init_department_root
    self.department_root = self.department.root
    if super_job_title
      self.name = super_job_title.name
      self.grade = super_job_title.grade
      self.description = super_job_title.description
    end
  end

  def sync_to_role_ids
    self.role_ids = cached_role_ids
    moved = Array(cached_role_ids_before_last_save) - Array(cached_role_ids)
    
    self.members.each do |member|
      r = Array(member.cached_role_ids) - moved
      r |= Array(cached_role_ids)
      member.cached_role_ids = r
      member.save
    end
  end
  
  
end
