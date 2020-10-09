module RailsOrg::Account
  extend ActiveSupport::Concern

  included do
    has_many :members, foreign_key: :identity, primary_key: :identity
    after_save :sync_to_members, if: -> { (saved_changes.keys & ['identity', 'user_id', 'confirmed']).present? }
  end

  def sync_to_members
    if confirmed? && self.user_id
      members.update_all(user_id: self.user_id)
    end
  end

end
