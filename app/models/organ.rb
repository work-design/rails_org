class Organ < ApplicationRecord
  include RailsCom::Taxon
  include RailsOrg::Organ
  include RailsRole::User if defined? RailsRole
end unless defined? Organ
