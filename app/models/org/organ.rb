module Org
  class Organ < ApplicationRecord
    include Com::Ext::Taxon
    include Model::Organ
    include Roled::Ext::Organ if defined? RailsCom
    include Profiled::Ext::Organ if defined? RailsProfile
  end
end
