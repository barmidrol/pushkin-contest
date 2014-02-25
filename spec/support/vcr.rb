VCR.configure do |c|
  c.cassette_library_dir = File.expand_path('../../vcr_cassettes', __FILE__)
  c.hook_into :webmock
  c.ignore_localhost = false
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    options = example.metadata.slice(:record, :match_requests_on, :tag).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end

  c.around(:each, :request) do |example|
    WebMock.disable!
    example.call
    Webmock.enable!
  end
end
