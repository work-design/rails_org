module RailsOrg::OrgConfig
  extend ActiveSupport::Concern
  included do
    belongs_to :job_title, optional: true
  end
  
end
