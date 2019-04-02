# Recaptcha.configure do |config|
#   config.public_key = ENV['RECAPTCHA_ASKME_PUBLIC_KEY']
#   config.private_key = ENV['RECAPTCHA_ASKME_PRIVATE_KEY']
# end

# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = ENV['RECAPTCHA_ASKME_PUBLIC_KEY']
  config.secret_key = ENV['RECAPTCHA_ASKME_PRIVATE_KEY']
end