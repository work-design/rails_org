module RailsOrg::JobDescription
  extend ActiveSupport::Concern
  
  included do
    attribute :requirements, :text
    attribute :advanced_requirements, :text
    attribute :english_requirement, :string
    attribute :degree_requirement, :string
    attribute :duties, :text
    attribute :salary_min, :integer
    attribute :salary_max, :integer
    
    belongs_to :department
  end


end
