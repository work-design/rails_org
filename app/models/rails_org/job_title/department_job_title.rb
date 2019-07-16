module RailsOrg::JobTitle::DepartmentJobTitle
  extend ActiveSupport::Concern
  included do
    belongs_to :department
    belongs_to :department_root, class_name: 'Department'
    belongs_to :super_job_title, optional: true

    acts_as_list column: :grade, scope: :department_root_id

    before_validation :init_department_root
  end

  def init_department_root
    self.department_root = self.department.root
    if super_job_title
      self.name = super_job_title.name
      self.grade = super_job_title.grade
      self.description = super_job_title.description
    end
  end
  
end
