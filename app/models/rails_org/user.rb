module RailsOrg::User
  extend ActiveSupport::Concern

  included do
    has_many :members, dependent: :nullify
    has_many :organs, through: :members
  end
  
  
  def available_account_identities
    accounts.where.not(identity: members.pluck(:identity)).confirmed
  end

end
