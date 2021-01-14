module Org
  class Member < ApplicationRecord
    include Roled::Model::User if defined? RailsRole
    include Model::Member
    include RailsProfile::Profile if defined? RailsProfile
  end
end
