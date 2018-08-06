Gem::Specification.new do |s|
  s.name        = 'taskit'
  s.version     = '0.0.3'
  s.date        = Time.now.strftime('%Y-%m-%d')

  s.summary     = ''
  s.description = ''
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/taskit'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split
  s.executables = ['taskit']

  s.add_dependency 'octokit', '~> 4.9.0'
  s.add_dependency 'octoauth', '~> 1.5.1'
  s.add_dependency 'faraday-http-cache', '~> 1.2.0'

  s.add_development_dependency 'rubocop', '~> 0.58.0'
  s.add_development_dependency 'goodcop', '~> 0.5.0'
  s.add_development_dependency 'rake', '~> 12.3.0'
  s.add_development_dependency 'rspec', '~> 3.8.0'
  s.add_development_dependency 'fuubar', '~> 2.3.0'
end
