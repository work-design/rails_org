module Org
  class Organ < ApplicationRecord
    include Com::Ext::Taxon
    include Model::Organ
    include Roled::Model::User if defined? RailsRole
  end
end
