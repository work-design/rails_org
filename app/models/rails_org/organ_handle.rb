module RailsOrg::OrganHandle
  extend ActiveSupport::Concern
  included do
    attribute :record_class, :string
    attribute :record_column, :string
    
    has_many :department_grants, dependent: :destroy
  end
  
end
