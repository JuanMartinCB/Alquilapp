require_relative 'boot'
require 'devise'
require 'simple_form'
require 'rails/all'
require 'httparty'
require 'aasm'
require 'active_storage_validations'
require 'active_storage'
require 'aws-sdk-s3'
require 'motor-admin'
require 'phonelib'
require 'geocoder'
require 'wicked_pdf'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Alquilapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_storage.service = :amazon
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "America/Argentina/Buenos_Aires"
    # config.eager_load_paths << Rails.root.join("extras")
    #config.generators.system_tests = nil
  end
end
