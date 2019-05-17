module RailsOrg::OrganHandle
  extend ActiveSupport::Concern
  included do
    has_many :department_grants, dependent: :destroy
  end
  
end
