class Member < ApplicationRecord
  include RailsRole::User if defined? RailsRole
  include RailsOrg::Member
end unless defined? Member
