Gem::Specification.new do |s|
  s.name        = 'tweeter_client'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.summary     = "This is an example!"
  s.description = "Much longer explanation of the example!"
  s.authors     = ["Josh Cheek"]
  s.email       = 'josh.cheek@example.com'
  s.files       = ["lib/tweeter_client.rb"]
  s.homepage    = 'https://rubygems.org/gems/example'
  s.add_runtime_dependency     'faraday', '~> 0.9'
  s.add_development_dependency 'rspec', '~> 3.0'
end
