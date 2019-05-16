module RailsOrg::OrgConfig
  extend ActiveSupport::Concern
  included do
    attribute :job_title_ids, :integer, array: true
  end
  
  def job_titles
    JobTitle.where(id: job_title_ids)
  end
  
end
