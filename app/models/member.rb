class Member < ApplicationRecord
  include Org::Model::Member
  include Roled::Model::User if defined? RailsRole
  include Profiled::Model::Profile if defined? RailsProfile
end
