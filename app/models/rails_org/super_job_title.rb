module RailsOrg::SuperJobTitle
  extend ActiveSupport::Concern
  included do
    attribute :grade, :integer
    
    has_many :job_titles, dependent: :nullify
    
    acts_as_list column: :grade, scope: :organ_id
  end

end
