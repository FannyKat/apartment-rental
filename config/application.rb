require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ApartmentRentalApp
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w(assets tasks))

    config.i18n.default_locale = :fr

    config.i18n.available_locales = [:fr, :en]

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
