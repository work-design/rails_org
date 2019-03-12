module RailsOrgUser
  extend ActiveSupport::Concern

  included do
    has_many :organs
  end


end
