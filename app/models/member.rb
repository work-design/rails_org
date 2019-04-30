class Member < ApplicationRecord
  include RailsOrg::Member
  include RailsRole::User
  include RailsTrade::Buyer
  include RailsTrade::User
  include RailsNotice::Receiver
end unless defined? Member
