module RailsOrg::OrganHandle
  extend ActiveSupport::Concern
  included do
    has_many :department_grants, dependent: :destroy
    has_many :job_titles, through: :department_grants
  end
  
end
