class User < ApplicationRecord
  include RailsRoleUser
  include RailsAuthUser
  include RailsNoticeReceivable

  attribute :timezone, :string, default: 'Beijing'
  has_one :profile, inverse_of: :user
  has_one :member, foreign_key: :email, primary_key: :email
  has_one :teacher
  has_one_attached :avatar

  def can_login?(params)
    if verified_status?
      return false
    end

    if self.password_digest.present? && authenticate(params[:password])
      self
    else
      errors.add :login, 'Incorrect email or password.'
      false
    end
  end

end

