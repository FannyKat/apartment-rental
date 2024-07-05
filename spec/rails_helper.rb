require 'rspec/rails'
require 'capybara/rspec'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
