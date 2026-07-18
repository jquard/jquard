Devise.setup do |config|
  config.mailer_sender = "no-reply@example.com"

  require "devise/orm/active_record"

  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end
