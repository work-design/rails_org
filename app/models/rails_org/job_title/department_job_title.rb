module RailsOrg::JobTitle::DepartmentJobTitle
  extend ActiveSupport::Concern
  included do
    belongs_to :department
    belongs_to :department_root, class_name: 'Department'
    belongs_to :super_job_title, optional: true

    acts_as_list column: :grade, scope: [:type, :department_root_id], top_of_list: ->(o){ o.top_grade }

    before_validation :init_department_root
    after_commit :sync_to_member_departments, if: -> { super_job_title_id.present? }, on: [:create, :destroy]
  end

  def init_department_root
    self.department_root = self.department.root
    if super_job_title
      self.name = super_job_title.name
      self.grade = super_job_title.grade
      self.description = super_job_title.description
    end
  end
  
  def sync_to_member_departments
    super_job_title.sync_to_member_departments
  end
  
end
