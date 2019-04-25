module RailsOrg::JobDescription
  extend ActiveSupport::Concern
  included do
    belongs_to :department
  end


end
