require "bundler"
Bundler.require(:default,:development)

Dir[File.expand_path('../support/*.rb', __FILE__)].each {|f| require f}

RSpec.configure do |config|

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run_excluding :live unless ENV['LIVE']

end
