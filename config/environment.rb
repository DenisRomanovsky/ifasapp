# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
Rails.logger = Le.new('e46d115c-9abd-4766-80e3-400a132dfd78', :debug => true, :local => true)