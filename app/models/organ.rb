class Organ < ApplicationRecord
  include RailsTaxon::Node
  include RailsOrg::Organ
end unless defined? Organ
