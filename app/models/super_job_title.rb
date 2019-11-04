class SuperJobTitle < ApplicationRecord
  include RailsRole::User # must included before Rails::JobTitle
  include RailsOrg::SuperJobTitle
end unless defined? SuperJobTitle
