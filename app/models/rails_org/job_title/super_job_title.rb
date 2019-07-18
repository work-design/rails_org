module RailsOrg::JobTitle::SuperJobTitle
  extend ActiveSupport::Concern
  included do
    has_many :department_job_titles, dependent: :destroy
    has_many :departments, through: :department_job_titles
    acts_as_list column: :grade, scope: [:organ_id, :super_job_title_id, :type]
  end

end
