module RailsOrg::SuperJobTitle
  extend ActiveSupport::Concern
  included do
    attribute :grade, :integer
    attribute :name, :string
    attribute :description, :string
    attribute :limit_member, :integer
  
    has_many :member_departments, dependent: :destroy
    has_many :members, through: :member_departments, source: :member
    has_many :same_job_titles, ->(o){ where(organ_id: o.organ_id) }, class_name: self.base_class.name, foreign_key: :department_root_id, primary_key: :department_root_id
    has_many :job_title_references, dependent: :delete_all
    has_many :lower_job_titles, through: :job_title_references, source: :department_job_titles
    has_many :departments, through: :job_title_references
    
    default_scope -> { order(grade: :asc) }
  
    after_update_commit :sync_grade_member_departments, if: -> { saved_change_to_grade? }
    
    acts_as_list column: :grade, scope: :organ_id
  end
  
  def lower_job_title_ids
    lower_job_titles.pluck(:id)
  end

  def sync_to_member_departments
    member_departments.update_all(department_ids: department_ids)
  end

  def sync_grade_member_departments
    member_departments.update_all(grade: self.grade)
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
