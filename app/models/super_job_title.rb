class SuperJobTitle < ApplicationRecord
  include RailsRole::User # must included before RailsOrg::SuperJobTitle
  include RailsOrg::SuperJobTitle
end unless defined? SuperJobTitle
