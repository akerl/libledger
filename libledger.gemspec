Gem::Specification.new do |s|
  s.name        = 'libledger'
  s.version     = '0.0.3'
  s.date        = Time.now.strftime('%Y-%m-%d')

  s.summary     = 'Library for interacting with Ledger files'
  s.description = 'Library for interacting with Ledger files'
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/libledger'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split

  s.add_development_dependency 'codecov', '~> 0.1.1'
  s.add_development_dependency 'fuubar', '~> 2.3.0'
  s.add_development_dependency 'goodcop', '~> 0.1.1'
  s.add_development_dependency 'rake', '~> 12.3.0'
  s.add_development_dependency 'rspec', '~> 3.7.0'
  s.add_development_dependency 'rubocop', '~> 0.52.0'
end
