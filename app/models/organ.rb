class Organ < ApplicationRecord
  include Com::Ext::Taxon
  include RailsOrg::Organ
  include Roled::Model::User if defined? RailsRole
end unless defined? Organ
