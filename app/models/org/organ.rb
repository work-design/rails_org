module Org
  class Organ < ApplicationRecord
    include Com::Ext::Taxon
    include Model::Organ
    include Roled::Model::User if defined? RailsRole
    include Profiled::Ext::Organ if defined? RailsProfile
  end
end
