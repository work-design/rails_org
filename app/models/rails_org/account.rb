module RailsOrg::Account
  extend ActiveSupport::Concern
  included do
    belongs_to :member, foreign_key: :identity, primary_key: :identity, optional: true
    after_save :sync_to_member, if: -> { saved_change_to_identity? || saved_change_to_confirmed? }
  end

  def sync_to_member
    if confirmed? && member
      member.user_id = self.user_id
      member.save
    end
  end

  def can_login_organ?
    confirmed? && member&.organ_token
  end

end
