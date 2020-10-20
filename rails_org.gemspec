$:.push File.expand_path('lib', __dir__)
require 'rails_org/version'

Gem::Specification.new do |s|
  s.name = 'rails_org'
  s.version = RailsOrg::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_org'
  s.summary = 'understandable, simple auth logic for Rails'
  s.description = 'SaaS multi org with members module'
  s.license = 'LGPL-3.0'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'Rakefile',
    'README.md'
  ]
  s.test_files = Dir['test/**/*']
  s.require_paths = ['lib']

  s.add_dependency 'rails_com', '~> 1.2'
  s.add_dependency 'rails_auth'
  s.add_dependency 'rails_profile'
  s.add_dependency 'rails_notice'
end
