require 'tweeter_client'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end


RSpec.describe TweeterClient do
  it 'creates and fetches a poster' do
    VCR.use_cassette("create a poster") do
      poster = TweeterClient::Poster.create name: 'Maguro'
      expect(poster.name).to eq 'Maguro'
    end
    # poster2 = TweeterClient::Poster.fetch poster.id
    # expect(poster2.name).to eq 'Maguro'
  end

  it 'updates a poster'
  it 'deletes a poster'

  context 'given a poster' do
    it 'tweets'
    # ...
  end
end
