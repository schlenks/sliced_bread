Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  PERF_MODE = ActiveModel::Type::Boolean.new.cast(ENV['PERF_MODE'])
  config.cache_classes = PERF_MODE

  # Do not eager load code on boot.
  config.eager_load = PERF_MODE

  config.log_level = PERF_MODE ? :error : :debug

  if PERF_MODE
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :dalli_store, 'cache'
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.action_mailer.perform_caching = ENV['PERF_MODE']

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = !ENV['PERF_MODE']

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = !ENV['PERF_MODE']

  # Show full error reports.
  config.consider_all_requests_local = true

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Suppress logger output for asset requests.
  config.assets.quiet = ENV['PERF_MODE']

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.web_console.whitelisted_ips = Socket.ip_address_list.select(&:ipv4?).map{
    |addrinfo| IPAddr.new(addrinfo.ip_address).mask(24)
  }


end
