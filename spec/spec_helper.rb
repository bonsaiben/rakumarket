require 'rakumarket'
require 'vcr'

Rakumarket.developer_id = ENV['DEVELOPER_ID'] || "foobar"

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'fixtures/vcr_casettes'
  c.filter_sensitive_data("<DEVELOPER_ID>") { Rakumarket.developer_id }
end

