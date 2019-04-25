module RailsOrg::OrganGrant
  extend ActiveSupport::Concern
  included do
    belongs_to :organ
    belongs_to :member, optional: true
    belongs_to :user, optional: true
    scope :valid, -> { where('expired_at >= ?', Time.now) }

    after_validation :update_token
    after_commit :sync_to_member, if: -> { saved_change_to_token? }
  end

  def update_token
    self.expired_at = 14.days.since
    self.token ||= organ.generate_token(sub: 'organ_auth', exp: expired_at)
    self
  end

  def sync_to_member
    if member
      if destroyed?
        organ_token = nil
      else
        organ_token = self.token
      end
      member.update(organ_token: organ_token)
    end
  end

end
