ENV['RAILS_ENV'] = 'test'
require 'factory_bot_rails'
require_relative '../test/dummy/config/environment'
require 'rails/test_help'
require 'minitest/mock'

ActiveRecord::Migrator.migrations_paths += [
  File.expand_path('../test/dummy/db/migrate', __dir__)
]
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods if defined?(FactoryBot)
end
