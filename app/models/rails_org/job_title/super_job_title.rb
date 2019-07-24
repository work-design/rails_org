module RailsOrg::JobTitle::SuperJobTitle
  extend ActiveSupport::Concern
  included do
    has_many :department_job_titles, dependent: :destroy
    has_many :departments, through: :department_job_titles
    has_many :lower_job_titles, ->(o){ default_where('grade-gte': o.grade) }, through: :department_job_titles, source: :same_job_titles
    
    acts_as_list column: :grade, scope: [:organ_id, :type, :super_job_title_id]
  end

  def sync_to_member_departments
    member_departments.update_all(department_ids: department_ids)
  end

end
