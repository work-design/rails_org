module RailsOrg::OrganGrant
  extend ActiveSupport::Concern
  included do
    attribute :token, :string
    attribute :expire_at, :datetime
    
    belongs_to :organ
    belongs_to :member, optional: true
    belongs_to :user, optional: true
    
    after_validation :update_token
  end

  def update_token
    self.expire_at = 14.days.since
    self.token ||= organ.generate_token(sub: 'organ_auth', exp: expire_at.to_i)
    self
  end
  
  def update_token!
    update_token
    save
  end
  
  def valid_period?
    self.expire_at > Time.now
  end

end
