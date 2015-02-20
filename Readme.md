If you enjoyed the gem building portion, I have an elective, "Building A Gem"
which covers all this stuff, in a tutorial-style, and in more detail
https://github.com/JoshCheek/elective-building-a-gem/


```sh
# =====  Making Our Client Into A Gem  =====

# initial repository
$ tree
.
├── fixtures
│   └── vcr_cassettes
│       └── create_a_poster.yml
├── lib
│   └── tweeter_client.rb
├── spec
│   └── tweeter_client_spec.rb
└── tweeter_client.gemspec

# tell Rubygems how to package my lib by using a gemspec
$ cat tweeter_client.gemspec
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

# tell Rubygems to look at the .gemspec and make a .gem
$ gem build tweeter_client.gemspec
  Successfully built RubyGem
  Name: tweeter_client
  Version: 0.1.0
  File: tweeter_client-0.1.0.gem

# install the gem so we can use it from pry or our library or wherever
$ gem install tweeter_client-0.1.0.gem

# Also note that you can tell Bundler to look on a github repo,
# and if it has a .gemspec, it will be able to use that gem without getting it from Rubygems
# http://bundler.io/git.html

# =====  Dissecting The Gem  =====

# make a directory to dissect it in
$ mkdir gemplay
$ cp tweeter_client-0.1.0.gem gemplay
$ cd gemplay
$ tree
.
└── tweeter_client-0.1.0.gem

# a gem is just a "tape archive" aka a bunch of files stuck together into one file
# lets extract them from the gem
$ tar -xf tweeter_client-0.1.0.gem
$ tree
.
├── checksums.yaml.gz
├── data.tar.gz
├── metadata.gz
└── tweeter_client-0.1.0.gem

# those "gz" files are "gnu zipped" files, just meaning they're compressed
$ gunzip checksums.yaml.gz
$ tree
.
├── checksums.yaml
├── data.tar.gz
├── metadata.gz
└── tweeter_client-0.1.0.gem

# the checksum tells us if the file looks the way it is expected to look
# useful to make sure it's not malware and didn't get corrupted since it was built

$ cat checksums.yaml
---
SHA1:
  metadata.gz: 25a69a6ed979cc09ffa6427b80545bb0d8f8d70d
  data.tar.gz: 891b280308693eaa42934913c6887e7eea0456b5
SHA512:
  metadata.gz: 2ef4424ab125cbc9936b849e17a3c3f069a783e0522747a426fb2619af293a69a23de8cb78e25f05ac9de2165af2c132353c9b889618d5d7ecf93553fdbe26f0
  data.tar.gz: cf853ab78e6fec63a4400de3119a7802be48553fc36cd46490f19cb18ef7c6484c3079b43bba34185aa4724c368c0c025410693d502aaf78a21036b511d7942a
$ sha1sum metadata.gz
  25a69a6ed979cc09ffa6427b80545bb0d8f8d70d  metadata.gz

# metadata is just a compressed YAML version of our gemspec
$ gunzip metadata.gz
$ ruby -r yaml -e 'puts YAML.load(File.read "metadata").name'
tweeter_client

# data is all the code we told it about (in our case, one file)
$ gunzip data.tar.gz
$ tar -xf data.tar
$ tree
.
├── checksums.yaml
├── data.tar
├── lib
│   └── tweeter_client.rb
├── metadata
└── tweeter_client-0.1.0.gem
$ cat lib/tweeter_client.rb | head -10
require 'faraday'
require 'json'

module TweeterClient
  def self.connection
    @connection ||= Faraday.new(:url => 'http://localhost:3000') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

# =====  Your Turn!  =====

# get the Rails .gem
$ gem fetch rails
$ ls -l
-rw-r--r--  1 josh  staff  1468416 Feb 20 12:53 rails-4.2.0.gem
```
