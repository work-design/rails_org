module RailsOrg::OrganGrant
  extend ActiveSupport::Concern
  included do
    belongs_to :organ
    belongs_to :member, optional: true
    belongs_to :user, optional: true
    scope :valid, -> { where('expire_at >= ?', Time.now) }

    after_validation :update_token
  end

  def update_token
    self.expire_at = 14.days.since
    self.token ||= organ.generate_token(sub: 'organ_auth', exp: expire_at)
    self
  end

end
