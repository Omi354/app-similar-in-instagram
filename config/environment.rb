# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# devise get started
Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
end
