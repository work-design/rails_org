module RailsOrg::User
  extend ActiveSupport::Concern

  included do
    has_many :members, dependent: :nullify
    has_many :organs, through: :members
    has_many :created_organs, class_name: 'Organ', foreign_key: :creator_id, dependent: :nullify
  end
  
  
  def available_account_identities
    accounts.where.not(identity: members.pluck(:identity)).confirmed
  end

end
