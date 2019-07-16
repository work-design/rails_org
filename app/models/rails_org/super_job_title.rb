module RailsOrg::SuperJobTitle
  extend ActiveSupport::Concern
  included do
    attribute :grade, :integer
    
    has_many :super_job_titles, dependent: :nullify
    
    acts_as_list column: :grade, scope: :organ_id
  end

end
