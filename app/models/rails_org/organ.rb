class Organ < ApplicationRecord
  has_many :departments, dependent: :destroy
  has_many :offices, dependent: :destroy
  has_many :rooms, through: :offices
  has_many :members, dependent: :nullify
  has_many :organ_tokens, dependent: :delete_all
  has_one_attached :logo

  after_initialize if: :new_record? do
    self.organ_uuid = UidHelper.nsec_uuid('ORG')
  end


  def get_organ_token(user_id)
    token = self.organ_tokens.valid.find_by(user_id: user_id)
    if token
      token
    else
      self.organ_tokens.where(user_id: user_id).delete_all
      token = organ_tokens.create(user_id: user_id)
    end
    token.token
  end

  def generate_token(**options)
    JwtHelper.generate_jwt_token(id, organ_uuid, options)
  end

end
