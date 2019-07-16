module RailsOrg::JobTitle::SuperJobTitle
  extend ActiveSupport::Concern
  included do
    has_many :job_titles, dependent: :destroy
    
    acts_as_list column: :grade, scope: [:organ_id, :super_job_title_id, :type]
  end

end
