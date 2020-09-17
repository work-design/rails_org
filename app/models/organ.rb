class Organ < ApplicationRecord
  include RailsTaxon::Node
  include RailsOrg::Organ
  include RailsRole::User if defined? RailsRole
end unless defined? Organ
