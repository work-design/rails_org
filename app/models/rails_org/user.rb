module RailsOrg::User
  extend ActiveSupport::Concern

  included do
    has_many :members, dependent: :nullify
    has_many :organs, through: :members
    has_many :organ_grants, dependent: :nullify
  end

  def available_account_identities
    accounts.where.not(identity: members.pluck(:identity)).confirmed
  end

  def member_organ_grants
    members.map { |i| i.get_organ_grant }
  end

end
