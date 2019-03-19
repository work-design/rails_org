class OrganGrant < ApplicationRecord
  belongs_to :organ
  belongs_to :member, optional: true
  belongs_to :user, optional: true
  scope :valid, -> { where('expired_at >= ?', Time.now) }

  after_validation :update_token

  def update_token
    self.expired_at = 14.days.since
    self.token ||= organ.generate_token(sub: 'organ_auth', exp: expired_at)
    self
  end

end
