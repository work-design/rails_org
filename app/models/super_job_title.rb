class SuperJobTitle < ApplicationRecord
  include RailsRole::User if defined? RailsRole # must included before RailsOrg::SuperJobTitle
  include RailsOrg::SuperJobTitle
end unless defined? SuperJobTitle
