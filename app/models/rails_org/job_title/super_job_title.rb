module RailsOrg::JobTitle::SuperJobTitle
  extend ActiveSupport::Concern
  included do
    has_many :job_title_references, dependent: :delete_all
    has_many :department_job_titles, through: :job_title_references
    has_many :departments, through: :job_title_references
    
    acts_as_list column: :grade, scope: [:organ_id, :type]
  end

  def sync_to_member_departments
    member_departments.update_all(department_ids: department_ids)
  end

end
