require 'vcr'
require 'webmock'

VCR.configure do |c|
  # Store cassettes in the following directory (I check these into source control)
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
end
