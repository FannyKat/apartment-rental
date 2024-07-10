require 'rspec/rails'
require 'capybara/rspec'
require 'selenium/webdriver'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu window-size=1920,1080] }
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
end

Capybara.javascript_driver = :headless_chrome

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Optional: Run all JavaScript tests with headless Chrome by default
  config.before(:each, type: :system) do
    driven_by :headless_chrome
  end
end
