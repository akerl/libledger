Gem::Specification.new do |s|
  s.name        = 'libledger'
  s.version     = '0.0.8'
  s.required_ruby_version = '>= 2.6'

  s.summary     = 'Library for interacting with Ledger files'
  s.description = 'Library for interacting with Ledger files'
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/libledger'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split

  s.add_development_dependency 'fuubar', '~> 2.5.1'
  s.add_development_dependency 'goodcop', '~> 0.9.7'
  s.add_development_dependency 'rake', '~> 13.0.6'
  s.add_development_dependency 'rspec', '~> 3.12.0'
  s.add_development_dependency 'rubocop', '~> 1.54.1'
  s.metadata['rubygems_mfa_required'] = 'true'
end
