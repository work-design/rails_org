class Organ < ApplicationRecord
  include Com::Ext::Taxon
  include Org::Model::Organ
  include Roled::Model::User if defined? RailsRole
end

