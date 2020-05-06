module RailsOrg::OrganGrant
  extend ActiveSupport::Concern

  included do
    attribute :token, :string
    attribute :expire_at, :datetime


    belongs_to :user

    after_initialize if: :new_record? do
      if member
        self.organ_id = member.organ_id
        self.user_id ||= member.user_id
        self.mock = true if user_id != member.user_id
      end
    end
    before_validation :update_token
  end

  def update_token
    self.expire_at = 14.days.since
    self.token ||= generate_token(sub: 'organ_auth', exp: expire_at.to_i)
  end

  def generate_token(**options)
    # fixme uuid 有待优化
    JwtHelper.generate_jwt_token(id, uuid, options)
  end

  def uuid
    organ&.organ_uuid || member&.id || user&.id
  end

  def update_token!
    update_token
    save
  end

  def valid_period?
    self.expire_at > Time.now
  end

end
