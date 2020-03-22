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

  def get_organ_grant(organ_id)
    grant = self.organ_grants.find_or_create_by(organ_id: organ_id)
    unless grant.valid_period?
      grant.update_token!
    end
    grant
  end

end
