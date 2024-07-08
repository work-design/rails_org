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

    attribute :theme_settings, :json, default: {}

    def admin_theme
      r = theme_settings['admin_menu']
      {
        'admin-menu' => "hsl(#{r['hue']}, #{r['saturation']}%, #{r['lightness']}%)",
        'admin-menu-darker' => "hsl(#{r['hue']}, #{r['saturation']}%, #{(r['lightness'].to_i * 0.8).round}%)"
      }.compact_blank!.map(&->(k,v){ "--#{k}: #{v}" }).join('; ')
    end
  end
end
