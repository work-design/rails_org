class Organ < ApplicationRecord
  prepend RailsTaxon::Node
  include RailsOrg::Organ
end unless defined? Organ
