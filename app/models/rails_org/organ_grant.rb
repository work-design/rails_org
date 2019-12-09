module RailsOrg::OrganGrant
  extend ActiveSupport::Concern
  included do
    attribute :token, :string
    attribute :expire_at, :datetime
    attribute :mock, :boolean, default: false

    belongs_to :organ, optional: true
    belongs_to :session_organ, class_name: 'Organ', optional: true
    belongs_to :member, optional: true
    belongs_to :user

    before_validation :update_token
  end

  def update_token
    self.expire_at = 14.days.since
    self.token ||= generate_token(sub: 'organ_auth', exp: expire_at.to_i)
    self.user_id = member.user_id if member
    self.session_organ_id ||= self.organ_id

    if organ
      organ.self_and_descendant_ids.include?(session_organ_id)
    end

    self
  end

  def generate_token(**options)
    JwtHelper.generate_jwt_token(id, uuid, options)
  end
  
  def uuid
    organ&.organ_uuid || member.id
  end
  
  def update_token!
    update_token
    save
  end
  
  def valid_period?
    self.expire_at > Time.now
  end

end
