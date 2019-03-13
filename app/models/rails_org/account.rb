require 'rails_auth/account'
puts 'account model from RailsOrg'
class Account < ApplicationRecord
  belongs_to :member, primary_key: :email, foreign_key: :account

end
