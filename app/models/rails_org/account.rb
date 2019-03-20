require 'rails_auth/account'
class Account < ApplicationRecord
  belongs_to :member, foreign_key: :identity, primary_key: :identity, optional: true

  after_save :sync_to_user, if: -> { saved_change_to_identity? }

  def sync_to_user
    if member
      member.user_id = self.user_id
      member.save
    end
  end

  def can_login_organ?
    confirmed? && member&.organ_token
  end

end
