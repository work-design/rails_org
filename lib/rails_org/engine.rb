require 'rails_com'
class RailsOrg::Engine < ::Rails::Engine

  config.autoload_paths += Dir[
    "#{config.root}/app/models/rails_org"
  ]

  config.factory_bot.definition_file_paths += Dir["#{config.root}/test/factories"] if defined?(FactoryBotRails)

  config.generators do |g|
    g.rails = {
      assets: false,
      stylesheets: false,
      helper: false,
      jbuilder: true
    }
    g.test_unit = {
      fixture: true,
      fixture_replacement: :factory_girl
    }
    g.templates.unshift File.expand_path('lib/templates', RailsCom::Engine.root)
  end

  initializer 'rails_org.assets.precompile' do |app|
    app.config.assets.precompile += ['rails_org_manifest.js']
  end

end # :nodoc:
