Gem::Specification.new do |s|
  s.name        = 'tweeter_client'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.summary     = "Client for the tweeter api"
  s.description = "Client to work with tweeter (https://github.com/turingschool-examples/tweeter) from Ruby"
  s.authors     = ["Josh Cheek"]
  s.email       = 'josh.cheek@example.com'
  s.files       = ["lib/tweeter_client.rb"]
  s.homepage    = 'https://rubygems.org/gems/example'
  s.add_runtime_dependency     'faraday', '~> 0.9'
  s.add_development_dependency 'rspec', '~> 3.0'
end
