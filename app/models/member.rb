class Member < ApplicationRecord
  include RailsRole::User
  include RailsOrg::Member
end unless defined? Member
