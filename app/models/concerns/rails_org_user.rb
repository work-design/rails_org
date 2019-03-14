module RailsOrgUser
  extend ActiveSupport::Concern

  included do
    has_many :members, dependent: :nullify
    has_many :organs, through: :members
  end


end
