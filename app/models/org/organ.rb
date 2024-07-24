module Org
  class Organ < ApplicationRecord
    include Com::Ext::Taxon
    include Model::Organ
    include Roled::Ext::Organ
    include Profiled::Ext::Organ if defined? RailsProfile
    include Factory::Ext::Organ if defined? RailsFactory
    include Trade::Ext::Organ if defined? RailsTrade
    include Ship::Ext::Organ if defined? RailsShip
    include Bench::Ext::Organ if defined? RailsBench
    include Crm::Ext::Organ if defined? RailsCrm
    include Wechat::Ext::Organ if defined? RailsWechat

  end
end
