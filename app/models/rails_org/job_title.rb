module RailsOrg::JobTitle
  extend ActiveSupport::Concern
  included do
    attribute :grade, :integer, default: 0
    attribute :name, :string
    attribute :description, :string
    attribute :limit_number, :integer

    belongs_to :department, optional: true
    belongs_to :department_root, class_name: 'Department', optional: true
    has_many :member_departments, dependent: :destroy
    has_many :members, through: :member_departments
    has_many :organ_grants, through: :member_departments
    
    default_scope -> { order(grade: :asc) }
    
    after_initialize :init_grade_and_department_root, if: :new_record?
    after_update_commit :sync_grade_member_departments, if: -> { saved_change_to_grade? }
  end
  
  def sync_grade_member_departments
    member_departments.update_all(grade: self.grade)
  end
  
  def init_grade_and_department_root
    if self.department
      self.department_root = self.department.root
      top = self.class.where(organ_id: department.organ_id, department_root_id: self.department_root.id).unscope(:order).order(grade: :desc).first
      unless top
        top = self.class.where(organ_id: self.organ_id, department_id: nil).unscope(:order).order(grade: :desc).first
      end
    else
      top = self.class.where(organ_id: self.organ_id, department_id: nil).unscope(:order).order(grade: :desc).first
    end

    self.grade = top ? top.grade + 1 : 0
  end
  
  def move_higher
  
  end
  
  def move_lower
  
  end

  def sync_to_role_ids
    self.role_ids = cached_role_ids
    moved = Array(cached_role_ids_before_last_save) - Array(cached_role_ids)
    
    self.organ_grants.each do |organ_grant|
      r = Array(organ_grant.cached_role_ids) - moved
      r |= Array(cached_role_ids)
      organ_grant.cached_role_ids = r
      organ_grant.save
    end
  end
  
  
end
