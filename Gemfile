source "https://rubygems.org"

ruby "3.3.0"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"

gem "sprockets-rails"

gem "pg"

gem "puma", ">= 5.0"

gem "importmap-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "jbuilder"

gem "redis", ">= 4.0.1"

gem "devise"

gem "pundit"

gem 'aasm'

gem 'faker'

# Translation i18n
gem 'rails-i18n', '~> 7.0.0'

gem 'rails_admin-i18n'

gem 'rails_admin', github: 'railsadminteam/rails_admin', branch: 'master'

# Front-End gems
gem 'cssbundling-rails'

gem 'bulma-rails'

gem 'simple_form'

gem "dartsass-rails", "~> 0.5.0"

gem 'haml-rails'

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false

# Upload images
gem 'mini_magick'

gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'annotate'
  gem 'rspec-rails'
  gem 'rspec-core'
  gem 'rails-erd'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
