Jquard.configure do |config|
  config.brand_name = "Jquard Admin Panel"
  config.authenticate_with { authenticate_user! }
  config.current_user_method = :current_user
  config.sign_out_path = -> { main_app.destroy_user_session_path }
end
