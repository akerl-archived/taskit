Gem::Specification.new do |s|
  s.name        = 'taskit'
  s.version     = '0.0.2'
  s.date        = Time.now.strftime("%Y-%m-%d")

  s.summary     = ''
  s.description = ""
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/taskit'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split
  s.executables = ['taskit']

  s.add_dependency 'octokit', '~> 3.5.2'
  s.add_dependency 'octoauth', '~> 0.0.9'
  s.add_dependency 'faraday-http-cache', '~> 0.4.2'

  s.add_development_dependency 'rubocop', '~> 0.27.0'
  s.add_development_dependency 'rake', '~> 10.4.0'
  s.add_development_dependency 'coveralls', '~> 0.7.1'
  s.add_development_dependency 'rspec', '~> 3.1.0'
  s.add_development_dependency 'fuubar', '~> 2.0.0'
end
