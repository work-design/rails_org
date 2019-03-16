require 'rails_auth/account'
puts 'account model from RailsOrg'
class Account < ApplicationRecord
  belongs_to :member, primary_key: :email, foreign_key: :account, optional: true

  after_save :sync_to_user, if: -> { saved_change_to_account? }


  def sync_to_user
    if member
      member.user_id = self.user_id
      member.save
    end
  end

end
