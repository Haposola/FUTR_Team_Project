
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Team::Application.initialize!
ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
    	address:              'smtp.gmail.com',
    	port:                 587,
    	domain:               'gmail.com',
    	user_name:            'haposola@gmail.com',
    	password:             'gg.19950609',
    	authentication:       'plain',
    	enable_starttls_auto: true
    }
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.raise_delivery_errors = true