class Member < ApplicationRecord
  include RailsOrg::Member
end unless defined? Member
