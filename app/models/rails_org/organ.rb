class Organ < ApplicationRecord
  has_many :departments, dependent: :destroy
  has_many :offices, dependent: :destroy
  has_one_attached :logo

  after_initialize if: :new_record? do
    self.organ_uuid = UidHelper.nsec_uuid('ORG')
    self.refresh_token
  end

  def refresh_token
    self.token = JwtHelper.generate_jwt_token(id, organ_uuid, sub: 'organ', exp: Time.now.to_i)
  end

  def refresh_token!
    refresh_token
    save
  end

end
