class Member < ApplicationRecord
  include Roled::Model::User if defined? RailsRole
  include RailsProfile::Profile if defined? RailsProfile
end
