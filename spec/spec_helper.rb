require 'rakumarket'
require 'webmock/rspec'

Rakumarket.developer_id = ENV['DEVELOPER_ID'] || "349556057ffad35f53c1d19ef5d01c06"
WebMock.disable_net_connect!

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

