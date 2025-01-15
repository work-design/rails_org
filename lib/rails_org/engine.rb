require 'rails_com'
module RailsOrg
  class Engine < ::Rails::Engine

    config.generators do |g|
      g.rails = {
        assets: false,
        stylesheets: false,
        helper: false
      }
      g.route false
      g.templates.unshift File.expand_path('lib/templates', RailsCom::Engine.root)
    end

    initializer 'rails_org.assets' do |app|
      app.config.assets.paths << root.join('app/assets/images')
    end

  end # :nodoc:
end
