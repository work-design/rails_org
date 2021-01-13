class Member < ApplicationRecord
  include Roled::Model::User if defined? RailsRole
  include RailsOrg::Member
  include RailsProfile::Profile if defined? RailsProfile
end unless defined? Member
